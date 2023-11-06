import 'package:first_app/models/user.dart';
import 'package:first_app/screens/vibes_board.dart';
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
      FocusScope.of(context).unfocus();
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
        await saveToLocalStorage('apiToken', response);
        await saveToLocalStorage('newUser', 'true');

        _apiToken = await getStringFromLocalStorage('apiToken');
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
    // var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    Widget content = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Form(
              key: _form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      cursorColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w400),
                      decoration: TextFormFieldStyle.textFormFieldStyle(
                          labelText: 'first name'),
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
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      cursorColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w400),
                      decoration: TextFormFieldStyle.textFormFieldStyle(
                          labelText: 'last name'),
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
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      cursorColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w400),
                      decoration: TextFormFieldStyle.textFormFieldStyle(
                          labelText: 'email address'),
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
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      cursorColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w400),
                      decoration: TextFormFieldStyle.textFormFieldStyle(
                          labelText: 'password'),
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _submit();
                    },
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color.fromRGBO(255, 255, 255, 0.1)),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.5),
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
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
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Registration complete. Token:  $_apiToken',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 20,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const VibesBoard(),
              ));
            },
            child: Container(
              height: 48,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color.fromRGBO(255, 255, 255, 0.1)),
              child: const Text(
                'Continue',
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
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
              child: Center(
                child: content,
              ),
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

class TextFormFieldStyle {
  static InputDecoration textFormFieldStyle({
    String labelText = "",
    String hintText = "",
  }) {
    return InputDecoration(
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
      labelText: labelText.toUpperCase(),
      labelStyle: const TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.3),
          fontWeight: FontWeight.w400),
    );
  }
}
