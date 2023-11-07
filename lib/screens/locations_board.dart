import 'dart:ui';

import 'package:first_app/widgets/vibe_modal.dart';
import 'package:flutter/material.dart';
import 'package:first_app/data/dummy_data.dart';
import 'package:first_app/models/location.dart';
import 'package:first_app/screens/vibes_board.dart';
import 'package:first_app/services/api_service.dart';
import 'package:first_app/utils/local_storage.dart';
import 'package:first_app/utils/parse_jwt.dart';
import 'package:first_app/widgets/vibe_item.dart';

const int usersLimit = 4;

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
      content = ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: _loadedItems.length,
        itemBuilder: (ctx, index) {
          return AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(255, 255, 255, 0.2),
                image: DecorationImage(
                  image: Image.network(
                    'https://via.placeholder.com/200/9e59da',
                    errorBuilder: (context, exception, stackTrace) {
                      return const Text('');
                    },
                  ).image,
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _loadedItems[index].name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(spacing: 0, runSpacing: 0, children: [
                      ...dummyVibes.asMap().entries.map((entry) {
                        int idx = entry.key;
                        return GestureDetector(
                          key: Key(entry.value.id.toString()),
                          onTap: () async {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Wrap(children: [
                                  VibeModal(
                                    name: dummyVibes[idx].name,
                                    description: dummyVibes[idx].description,
                                    background: dummyVibes[idx].background,
                                  ),
                                ]);
                              },
                            );

                            // setState(() {
                            //   _unSelected.add(_selected[idx]);
                            //   _selected.remove(_selected[idx]);
                            // });
                          },
                          child: VibeItem(
                            vibe: entry.value,
                          ),
                        );
                      })
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      for (int i = 0;
                          i <
                              (dummyUsers.length < usersLimit
                                  ? dummyUsers.length
                                  : usersLimit);
                          i++) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.5,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(
                                dummyUsers[i].photo!.split(',')[0]),
                          ),
                        ),
                      ],
                      const SizedBox(
                        width: 16,
                      ),
                      if (dummyUsers.length > usersLimit) ...[
                        UsersNumberChip(
                          number: dummyUsers.length - usersLimit,
                        ),
                      ],
                      const SizedBox(
                        width: 8,
                      ),
                      const FlocksNumberChip(
                        number: 34,
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                  cursorColor: Theme.of(context).colorScheme.onPrimaryContainer,
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
            Expanded(child: content),
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
                onTap: () async {
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

class UsersNumberChip extends StatelessWidget {
  const UsersNumberChip({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Text(
        '+$number',
        style: const TextStyle(
          height: 1.0,
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class FlocksNumberChip extends StatelessWidget {
  const FlocksNumberChip({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 4, right: 4, bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromRGBO(255, 151, 54, 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number',
            style: const TextStyle(
              height: 1.0,
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: const Color.fromRGBO(0, 0, 0, 0.5),
            ),
            child: Text(
              'flocks'.toUpperCase(),
              style: const TextStyle(
                height: 1.0,
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
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
