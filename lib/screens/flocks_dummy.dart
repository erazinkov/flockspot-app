import 'package:first_app/data/dummy_data.dart';
import 'package:first_app/models/flock_dummy.dart';
import 'package:first_app/models/vibe.dart';
import 'package:first_app/screens/flock.dart';
import 'package:first_app/widgets/vibe_item.dart';
import 'package:flutter/material.dart';

class FlocksScreen extends StatefulWidget {
  const FlocksScreen({super.key});

  @override
  State<FlocksScreen> createState() => _FlocksScreenState();
}

class _FlocksScreenState extends State<FlocksScreen> {
  final List<Flock> _flockItems = dummyFlocks;
  final List<Vibe> _vibeItems = dummyVibes;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: _flockItems.length,
      itemBuilder: (ctx, index) {
        return Dismissible(
          key: ValueKey(_flockItems[index].id),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => FlockScreen(
                  flock: _flockItems[index],
                ),
              ));
            },
            child: Card(
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
                                  for (int i = 0;
                                      i < _flockItems[index].users.length;
                                      i++)
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: 0.5,
                                        child: CircleAvatar(
                                          radius: 24,
                                          backgroundImage: NetworkImage(
                                            _flockItems[index]
                                                .users[i]
                                                .user
                                                .photo!
                                                .split(',')[0],
                                          ),
                                        ))
                                ],
                              ),
                              PopupMenuButton(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Icon(
                                    Icons.more_horiz,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0; i < _vibeItems.length; i++)
                                  VibeItem(vibe: _vibeItems[i]),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                      '${_flockItems[index].meets.length.toString()} meets'
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.5),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                      _flockItems[index]
                                          .meets[0]
                                          .place
                                          .title
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.2),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              const Icon(
                                Icons.circle,
                                size: 8,
                                color: Color.fromRGBO(255, 51, 0, 1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))),
          ),
        );
      },
    );

    return content;
  }
}
