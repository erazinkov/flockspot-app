import 'package:first_app/screens/signup.dart';
import 'package:first_app/services/api_service.dart';
import 'package:first_app/utils/local_storage.dart';
import 'package:first_app/widgets/login_item.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  var _isLoading = false;
  final _form = GlobalKey<FormState>();
  late String? _apiToken;
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _setItem(String identifier) {
    print(identifier);
  }

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (isValid) {
      _form.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      final response =
          await ApiService.authLogin(_enteredEmail, _enteredPassword);

      if (response != null) {
        await LocalStorage.saveToLocalStorage('apiToken', response);
        await LocalStorage.saveToLocalStorage('newUser', 'false');

        _apiToken = await LocalStorage.getStringFromLocalStorage('apiToken');
      }

      Future.delayed(const Duration(seconds: 3)).then((value) {
        setState(() {
          _isLoading = false;
          if (response != null) {
            print(response);
            // _isRegister = true;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Form(
            key: _form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  cursorColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder().copyWith(
                        borderSide: const BorderSide().copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer)),
                    labelText: 'Email Address',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w400),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }

                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredEmail = newValue!;
                  },
                ),
                TextFormField(
                  cursorColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder().copyWith(
                        borderSide: const BorderSide().copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer)),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w400),
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().length < 8
                        // || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value)
                        ) {
                      return 'Password must be at least 8 characters long';
                    }

                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredPassword = newValue!;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    _submit();
                  },
                  child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Color.fromRGBO(255, 255, 255, 0.2)),
                      child: Text(
                        'Ok',
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      )),
                ),
              ],
            ))
      ],
    );

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.contain)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        children: [
                          LoginItem(
                            label: 'Gmail',
                            iconPath: 'assets/icons/google.png',
                            onSelectItem: (label) {
                              _setItem(label);
                            },
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          LoginItem(
                            label: 'Insta',
                            iconPath: 'assets/icons/instagram.png',
                            onSelectItem: (label) {
                              _setItem(label);
                            },
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          LoginItem(
                            label: 'Meta',
                            iconPath: 'assets/icons/facebook.png',
                            onSelectItem: (label) {
                              _setItem(label);
                            },
                          ),
                        ],
                      ),
                    ),
                    content,
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don’t have account?',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.3),
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => SignupScreen()));
                  },
                  child: const Text(' Sing Up ',
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.75),
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
