import 'package:first_app/models/flock_dummy.dart';
import 'package:flutter/material.dart';

enum Screen { flock, chat }

class FlockScreen extends StatefulWidget {
  const FlockScreen({super.key, required this.flock});

  final Flock flock;

  @override
  State<FlockScreen> createState() => _FlockScreenState();
}

class _FlockScreenState extends State<FlockScreen> {
  Screen selectedScreen = Screen.flock;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    Widget content = SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 16),
              height: screenSize.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color.fromRGBO(112, 0, 254, 0.59),
                    Color.fromRGBO(143, 90, 255, 0.66),
                    Color.fromRGBO(23, 5, 74, 0),
                  ])),
              width: double.infinity,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attending Yoga workshop',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 40,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${widget.flock.meets[0].place.title}, ${widget.flock.meets[0].place.location.name}'
                            .toUpperCase(),
                        style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );

    if (selectedScreen == Screen.chat) {
      content = Center(
        child: Text('Chat...',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 40,
                fontWeight: FontWeight.w600)),
      );
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: SizedBox(
            height: 32,
            child: SegmentedButton(
              style: ButtonStyle(
                side: MaterialStateProperty.resolveWith<BorderSide>(
                    (Set<MaterialState> states) {
                  return const BorderSide(color: Colors.transparent);
                }),
                padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                    (Set<MaterialState> states) {
                  return const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 0);
                }),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.selected)
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.primary;
                }),
              ),
              showSelectedIcon: false,
              segments: <ButtonSegment<Screen>>[
                ButtonSegment<Screen>(
                    value: Screen.flock,
                    label: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        'flock'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: selectedScreen == Screen.flock
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onPrimary),
                      ),
                    )),
                ButtonSegment<Screen>(
                    value: Screen.chat,
                    label: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text('chat'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: selectedScreen == Screen.chat
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onPrimary)),
                    ))
              ],
              selected: <Screen>{selectedScreen},
              onSelectionChanged: (Set<Screen> newSelection) {
                setState(() {
                  selectedScreen = newSelection.first;
                });
              },
            ),
          ),
          actions: [
            PopupMenuButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: ImageIcon(
                  AssetImage('assets/icons/menu.png'),
                  size: 32,
                ),
              ),
              onSelected: (value) {},
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'Item0',
                    child: Text(
                      'Item0',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Item1',
                    child: Text(
                      'Item1',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                  ),
                ];
              },
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        body: content);
  }
}
