import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Location? _pickedLocation;
  var _isGettingLocation = false;

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    setState(() {
      _isGettingLocation = false;
    });

    print(locationData.latitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = const Text(
      'Uh oh ... nothing here!',
      style: TextStyle(color: Colors.white, fontSize: 28),
    );

    if (_isGettingLocation) {
      previewContent = CircularProgressIndicator(
          color: Theme.of(context).colorScheme.onPrimaryContainer);
    }

    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 32,
            child: previewContent,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Try selecting another tab!',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          const SizedBox(
            height: 16,
          ),
          TextButton(
              style: const ButtonStyle().copyWith(
                  backgroundColor: const MaterialStatePropertyAll(
                      Color.fromRGBO(255, 255, 255, 0.2))),
              onPressed: _getCurrentLocation,
              child: Text('Get current location!',
                  style: const TextStyle().copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  )))
        ],
      ),
    );

    return content;
  }
}
