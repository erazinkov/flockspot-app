import 'package:first_app/models/flock.dart';
import 'package:first_app/widgets/vibe_item.dart';
import 'package:flutter/material.dart';

class FlockItem extends StatelessWidget {
  const FlockItem({super.key, required this.flock});

  final Flock flock;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color.fromRGBO(255, 255, 255, 0.1),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          for (int i = 0; i < flock.users!.length; i++)
                            Align(
                                alignment: Alignment.centerLeft,
                                widthFactor: 0.5,
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                    flock.users![i].photo!.split(',')[0],
                                  ),
                                ))
                        ],
                      ),
                      PopupMenuButton(
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: ImageIcon(
                              const AssetImage('assets/icons/menu.png'),
                              size: 24,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ),
                        onSelected: (value) {},
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: 'Report',
                              child: Text(
                                'Report Flock',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'Leave',
                              child: Text(
                                'Leave Flock',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'Chat',
                              child: Text(
                                'View Chat',
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
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for (int i = 0;
                  //           i < flock.meets[0].place.vibes.length;
                  //           i++)
                  //         VibeItem(vibe: flock.meets[0].place.vibes[i]),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 16),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Text(
                  //             '${flock.meets.length.toString()} meets'
                  //                 .toUpperCase(),
                  //             style: const TextStyle(
                  //                 color: Color.fromRGBO(255, 255, 255, 0.5),
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w500)),
                  //         const SizedBox(
                  //           width: 8,
                  //         ),
                  //         Text(flock.meets[0].place.title.toUpperCase(),
                  //             style: const TextStyle(
                  //                 color: Color.fromRGBO(255, 255, 255, 0.2),
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w500)),
                  //       ],
                  //     ),
                  //     const Icon(
                  //       Icons.circle,
                  //       size: 8,
                  //       color: Color.fromRGBO(255, 51, 0, 1),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            )));
  }
}
