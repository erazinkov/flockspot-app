// import 'package:first_app/screens/tabs.dart';
// import 'package:first_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

enum Setting {
  one,
  two,
  three,
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.currentSettings});

  final Map<Setting, bool> currentSettings;

  @override
  State<StatefulWidget> createState() {
    return _SettingsScreen();
  }
}

class _SettingsScreen extends State<SettingsScreen> {
  var _settingOneSet = false;
  var _settingTwoSet = false;
  var _settingThreeSet = false;

  @override
  void initState() {
    super.initState();
    _settingOneSet = widget.currentSettings[Setting.one]!;
    _settingTwoSet = widget.currentSettings[Setting.two]!;
    _settingThreeSet = widget.currentSettings[Setting.three]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'flocks') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) {
      //             return TabsScreen();
      //           },
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Setting.one: _settingOneSet,
            Setting.two: _settingTwoSet,
            Setting.three: _settingThreeSet,
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _settingOneSet,
              onChanged: (isChecked) {
                setState(() {
                  _settingOneSet = isChecked;
                });
              },
              title: Text(
                'S1',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'S1 description.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _settingTwoSet,
              onChanged: (isChecked) {
                setState(() {
                  _settingTwoSet = isChecked;
                });
              },
              title: Text(
                'S2',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'S2 description.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _settingThreeSet,
              onChanged: (isChecked) {
                setState(() {
                  _settingThreeSet = isChecked;
                });
              },
              title: Text(
                'S3',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'S3 description.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
