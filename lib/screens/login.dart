import 'package:first_app/providers/user_credentials.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_app/models/user_credentials.dart';
import 'package:first_app/screens/signup.dart';
import 'package:first_app/screens/vibes_board.dart';
import 'package:first_app/services/api_service.dart';
import 'package:first_app/utils/local_storage.dart';
import 'package:first_app/utils/parse_jwt.dart';
import 'package:first_app/widgets/login_item.dart';

import '../models/user.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends ConsumerState<LoginScreen> {
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
      FocusScope.of(context).unfocus();
      _form.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      final response = await ApiService.login(_enteredEmail, _enteredPassword);

      if (response != null) {
        await saveToLocalStorage('apiToken', response);
        await saveToLocalStorage('newUser', 'false');

        var id = parseJwt(response)['id'];
        var user = await ApiService().getUserById(id);
        UserCredentials userCredentials = UserCredentials(
          email: user!.email,
          password: user.password,
          token: response,
        );
        ref.read(userCredentialsProvider.notifier).set(userCredentials);
        // var uc = ref.watch(userCredentialsProvider);
        // print(uc.email);
        // _apiToken = await getStringFromLocalStorage('apiToken');
        // print(parseJwt(_apiToken!));
      }

      Future.delayed(const Duration(seconds: 3)).then((value) {
        setState(() {
          _isLoading = false;
          if (response != null) {
            print(response);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => VibesBoard(),
            ));
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
                Container(
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
                const SizedBox(
                  height: 8,
                ),
                Container(
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
                      'Log In',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  content,
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'or use'.toUpperCase(),
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.3),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                ],
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (ctx) => const SignupScreen()));
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
