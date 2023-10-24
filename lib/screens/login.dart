import 'package:first_app/screens/signin.dart';
import 'package:first_app/widgets/login_item.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  void _setItem(String identifier) {
    print(identifier);
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
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.contain)),
                child: Center(
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
              ),
            ),
            SizedBox(
              height: isPortrait ? 56 : 28,
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
                        MaterialPageRoute(builder: (ctx) => SigninScreen()));
                  },
                  child: const Text(' Sing In ',
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
