import 'package:first_app/data/dummy_data.dart';
import 'package:first_app/models/flock_dummy.dart';
import 'package:flutter/material.dart';

class FlocksScreen extends StatefulWidget {
  const FlocksScreen({super.key});

  @override
  State<FlocksScreen> createState() => _FlocksScreenState();
}

class _FlocksScreenState extends State<FlocksScreen> {
  final List<Flock> _flockItems = dummyFlocks;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: _flockItems.length,
      itemBuilder: (ctx, index) {
        return Dismissible(
          key: ValueKey(_flockItems[index].id),
          child: Card(
              color: const Color.fromRGBO(255, 255, 255, 0.05),
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey),
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
                                    // value: SampleItem.itemOne,
                                    child: Text(
                                      'Report Flock',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    // value: SampleItem.itemOne,
                                    child: Text(
                                      'Leave Flock',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    // value: SampleItem.itemOne,
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
                        Row(
                          children: [
                            Text(_flockItems[index].id.toString(),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer)),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(_flockItems[index].flockSize.toString(),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer)),
                          ],
                        ),
                      ],
                    ),
                  ))),
        );
      },
    );

    return content;
  }
}
