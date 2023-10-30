import 'package:first_app/models/location.dart';
import 'package:first_app/screens/vibes_board.dart';
import 'package:first_app/services/api_service.dart';
import 'package:first_app/utils/local_storage.dart';
import 'package:first_app/utils/parse_jwt.dart';
import 'package:flutter/material.dart';

class LocationsBoard extends StatefulWidget {
  const LocationsBoard({Key? key}) : super(key: key);

  @override
  State<LocationsBoard> createState() => _LocationsBoardState();
}

class _LocationsBoardState extends State<LocationsBoard> {
  var _isLoading = true;
  late List<Location> _loadedItems = [];

  void _loadItems() async {
    _loadedItems = (await ApiService().getAllLocations())!;
    Future.delayed(const Duration(seconds: 3)).then((value) => setState(() {
          _isLoading = false;
        }));
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'No items...',
        style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
    if (_isLoading) {
      content = Center(
        child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onPrimaryContainer),
      );
    }
    if (_loadedItems.isNotEmpty) {
      content = SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            ..._loadedItems.map((e) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => VibesBoard(),
                  ));
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromRGBO(255, 255, 255, 0.2)),
                    child: Text(
                      e.name,
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    )),
              );
            }),
          ],
        ),
      );
      // content = SizedBox(
      //     width: double.infinity,
      //     child: Column(children: [
      //       ..._loadedItems.asMap().entries.map((entry) {
      //         int idx = entry.key;
      //         return GestureDetector(
      //           onTap: () {},
      //           child: Text(entry.value.name,
      //               style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 16,
      //                   fontWeight: FontWeight.w400)),
      //         );
      //       })
      //     ]));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'select your location'.toUpperCase(),
            style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.3),
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 76,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Select',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              content,
            ],
          ),
        ));
  }
}
