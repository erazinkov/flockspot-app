import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';

import 'package:first_app/widgets/boards/location_item.dart';
import 'package:first_app/models/location.dart';
import 'package:first_app/services/api_service.dart';

class Locations extends StatefulWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  final _form = GlobalKey<FormState>();
  var _isLoading = true;
  late List<Location> _loadedItems = [];
  late int _selectedIndex = 0;
  Timer? _debounce;

  void _loadItems() async {
    _loadedItems = (await ApiService().getLocations())!;

    Future.delayed(
      const Duration(seconds: 3),
    ).then(
      (value) => setState(() {
        _isLoading = false;
      }),
    );
  }

  void _handleOnChanged(String query) async {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 1500), () async {
      setState(() {
        _loadedItems.clear();
        _isLoading = true;
      });
      _loadedItems = (await ApiService().getLocationsByNameContains(query))!;
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text(
        'No items...',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
    if (_isLoading) {
      content = const Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      ));
    }
    if (_loadedItems.isNotEmpty) {
      content = ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: _loadedItems.length,
        itemBuilder: (ctx, index) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: index == _selectedIndex
                            ? const Color.fromRGBO(251, 255, 54, 1.0)
                            : Colors.transparent)),
                child: LocationItem(
                  location: _loadedItems[index],
                ),
              ),
              if (_selectedIndex != index) ...[
                Positioned(
                  top: 28,
                  right: 28,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                      child: const ImageIcon(
                        size: 16,
                        color: Colors.white,
                        AssetImage('assets/icons/plus.png'),
                      ),
                    ),
                  ),
                ),
              ]
            ],
          );
        },
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
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: _form,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                    decoration: TextFormFieldStyles.textFormFieldStyles(
                        labelText: 'search your location'),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Field is empty.';
                      }

                      return null;
                    },
                    onChanged: _handleOnChanged,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: content,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (ctx) => const SignupScreen(),
                  // ));
                },
                child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4)),
                        color: Color.fromRGBO(251, 255, 54, 1)),
                    child: const Text(
                      'Let\'s start',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    )),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (ctx) => LoginScreen(),
                  // ));
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10.0,
                      sigmaY: 10.0,
                    ),
                    child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.1)),
                        child: const Text(
                          'Add own',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextFormFieldStyles {
  static InputDecoration textFormFieldStyles({
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
