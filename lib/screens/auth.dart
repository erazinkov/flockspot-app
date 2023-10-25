import 'package:first_app/screens/login.dart';
import 'package:first_app/screens/signup.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthScreen();
  }
}

class _AuthScreen extends State<AuthScreen> {
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
                  child: Text(
                    'flocks',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontFamily: 'TTChocolate',
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => SignupScreen(),
                      ));
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
                            color: Color.fromRGBO(255, 255, 255, 0.2)),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => LoginScreen(),
                      ));
                    },
                    child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                bottomLeft: Radius.circular(4),
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12)),
                            color: Color.fromRGBO(255, 255, 255, 0.2)),
                        child: Text(
                          'Log In',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                )
              ],
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
