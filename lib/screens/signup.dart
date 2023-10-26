import 'package:first_app/models/user.dart';
import 'package:first_app/services/api_service.dart';
import 'package:flutter/material.dart';

import '../utils/local_storage.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() {
    return _SignupScreen();
  }
}

class _SignupScreen extends State<SignupScreen> {
  var _isLoading = false;
  var _isRegister = false;
  final _form = GlobalKey<FormState>();
  late String? _apiToken;

  var _enteredFirstName = '';
  var _enteredLastName = '';
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (isValid) {
      _form.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      final response = await ApiService.getToken(User(
          email: _enteredEmail,
          firstName: _enteredFirstName,
          lastName: _enteredLastName,
          password: _enteredPassword));

      if (response != null) {
        await LocalStorage.saveToLocalStorage('apiToken', response);
        await LocalStorage.saveToLocalStorage('newUser', 'true');

        _apiToken = await LocalStorage.getStringFromLocalStorage('apiToken');
      }

      Future.delayed(const Duration(seconds: 3)).then((value) {
        setState(() {
          _isLoading = false;
          if (response != null) {
            _isRegister = true;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    Widget content = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Form(
              key: _form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    cursorColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder().copyWith(
                          borderSide: const BorderSide().copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer)),
                      labelText: 'First Name',
                      labelStyle: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w400),
                    ),
                    keyboardType: TextInputType.name,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a valid first name';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _enteredFirstName = newValue!;
                    },
                  ),
                  TextFormField(
                    cursorColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder().copyWith(
                          borderSide: const BorderSide().copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer)),
                      labelText: 'Last Name',
                      labelStyle: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w400),
                    ),
                    keyboardType: TextInputType.name,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a valid last name';
                      }

                      return null;
                    },
                    onSaved: (newValue) {
                      _enteredLastName = newValue!;
                    },
                  ),
                  TextFormField(
                    cursorColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
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
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
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
                    cursorColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
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
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
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
      ),
    );

    if (_isLoading) {
      content = CircularProgressIndicator(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      );
    } else if (_isRegister) {
      content = Text(
        'Registration complete. Token:  $_apiToken',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontSize: 20,
            fontWeight: FontWeight.w400),
      );
    }

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
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: const AssetImage('assets/images/background.png'),
                        fit: isPortrait ? BoxFit.contain : BoxFit.cover)),
                child: Center(
                  child: content,
                ),
              ),
            ),
            SizedBox(
              height: isPortrait ? 56 : 28,
            ),
            const Text(
              'Welcome to Flockspot',
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.3),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
