import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SigninScreen();
  }
}

class _SigninScreen extends State<SigninScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() {
    final isValid = _form.currentState!.validate();

    if (isValid) {
      _form.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Form(
                            key: _form,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                    enabledBorder: const UnderlineInputBorder()
                                        .copyWith(
                                            borderSide: const BorderSide()
                                                .copyWith(
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 0.5))),
                                    focusedBorder: const UnderlineInputBorder()
                                        .copyWith(
                                            borderSide: const BorderSide()
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimaryContainer)),
                                    labelText: 'Email Address',
                                    labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
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
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                    enabledBorder: const UnderlineInputBorder()
                                        .copyWith(
                                            borderSide: const BorderSide()
                                                .copyWith(
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 0.5))),
                                    focusedBorder: const UnderlineInputBorder()
                                        .copyWith(
                                            borderSide: const BorderSide()
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimaryContainer)),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().length < 6) {
                                      return 'Password must be at least 6 characters long';
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
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (ctx) => SigninScreen(),
                                    ));
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      _submit();
                                    },
                                    child: Container(
                                        height: 48,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.2)),
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
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
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
