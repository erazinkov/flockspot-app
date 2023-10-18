import 'package:first_app/models/availability.dart';
import 'package:first_app/models/flock_dummy.dart';
import 'package:first_app/widgets/vibe_item.dart';
import 'package:flutter/material.dart';

enum Screen { flock, chat }

// (String, String) formattedSuggestedTime(Availability suggestedTime) {
//   String dayOfWeek = 'unknown';
//   switch (suggestedTime.dayOfWeek) {
//     case DayOfWeek.Sun:
//       dayOfWeek = 'sunday';
//     case DayOfWeek.Mon:
//       dayOfWeek = 'monday';
//     case DayOfWeek.Tue:
//       dayOfWeek = 'tuesday';
//     case DayOfWeek.Wed:
//       dayOfWeek = 'wednesday';
//     case DayOfWeek.Thu:
//       dayOfWeek = 'thursday';
//     case DayOfWeek.Fri:
//       dayOfWeek = 'friday';
//     case DayOfWeek.Sat:
//       dayOfWeek = 'saturday';
//     default:
//       dayOfWeek = 'unknown';
//   }
//   String startAt =
//       '${suggestedTime.startAt.hour}:${suggestedTime.startAt.minute}';

//   return (
//     dayOfWeek,
//     startAt,
//   );
// }

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

    Widget content = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        const SizedBox(
                          height: 24,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0;
                                  i < widget.flock.meets[0].place.vibes.length;
                                  i++)
                                VibeItem(
                                    vibe: widget.flock.meets[0].place.vibes[i]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'next meet'.toUpperCase(),
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Card(
                    color: const Color.fromRGBO(255, 255, 255, 0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    for (int i = 0;
                                        i < widget.flock.users.length;
                                        i++)
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: 0.5,
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundImage: NetworkImage(
                                              widget.flock.users[i].user.photo!
                                                  .split(',')[0],
                                            ),
                                          ))
                                  ],
                                ),
                                PopupMenuButton(
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: ImageIcon(
                                        const AssetImage(
                                            'assets/icons/menu.png'),
                                        size: 24,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer),
                                  ),
                                  onSelected: (value) {},
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        value: true,
                                        child: Text(
                                          'Going',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: false,
                                        child: Text(
                                          'Not going',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer),
                                        ),
                                      ),
                                    ];
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${widget.flock.suggestedTimes[0].formattedDayOfWeek} ${widget.flock.suggestedTimes[0].formattedStartAt}',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Icon(
                                  Icons.circle,
                                  size: 24,
                                  color: Color.fromRGBO(30, 255, 0, 1),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text.rich(
                              TextSpan(
                                text: 'by ',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                                children: const [
                                  TextSpan(
                                    text: '@Adam_Bennet',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Text(
                    'members'.toUpperCase(),
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 8,
                        children: [
                          for (int i = 0; i < widget.flock.users.length; i++)
                            SizedBox(
                              width: 96,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 48,
                                    backgroundImage: NetworkImage(
                                      widget.flock.users[i].user.photo!
                                          .split(',')[0],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    '${widget.flock.users[i].user.firstName} ${widget.flock.users[i].user.lastName[0]}.'
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.5),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
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
