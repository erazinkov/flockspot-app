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
      content = Expanded(
        child: ListView.builder(
          itemCount: _loadedItems.length,
          itemBuilder: (ctx, index) {
            return AspectRatio(
              aspectRatio: 1,
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(255, 255, 255, 0.2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _loadedItems[index].name,
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'vibes list',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'choose location'.toUpperCase(),
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
              Form(
                // key: _form,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    cursorColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w400),
                    decoration: TextFormFieldStyle.textFormFieldStyle(
                        labelText: 'search your location'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Field is empty.';
                      }

                      return null;
                    },
                    onChanged: (newValue) {},
                    // onSaved: (newValue) {
                    //   _enteredEmail = newValue!;
                    // },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              content,
            ],
          ),
        ));
  }
}

class TextFormFieldStyle {
  static InputDecoration textFormFieldStyle({
    String labelText = "",
    String hintText = "",
  }) {
    return InputDecoration(
      prefixIconColor: Colors.white,
      prefixIcon: const ImageIcon(
        size: 24,
        color: Colors.white,
        AssetImage('assets/icons/search.png'),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 0,
          color: Color.fromRGBO(255, 255, 255, 0.0),
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 0,
          color: Color.fromRGBO(255, 255, 255, 0.0),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 0,
          color: Color.fromRGBO(255, 255, 255, 0.0),
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 0,
          color: Color.fromRGBO(255, 255, 255, 0.0),
        ),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(
          width: 0,
          color: Color.fromRGBO(255, 255, 255, 0.0),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 0,
          color: Color.fromRGBO(255, 255, 255, 0.0),
        ),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelText: labelText.toUpperCase(),
      labelStyle: const TextStyle(
          fontSize: 14,
          color: Color.fromRGBO(255, 255, 255, 0.3),
          fontWeight: FontWeight.w400),
    );
  }
}
