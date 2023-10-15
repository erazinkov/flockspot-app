import 'package:first_app/models/flock_dummy.dart';
import 'package:flutter/material.dart';

class FlockScreen extends StatelessWidget {
  const FlockScreen({super.key, required this.flock});

  final Flock flock;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
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
                          '${flock.meets[0].place.title}, ${flock.meets[0].place.location.name}'
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
      ),
    );
  }
}
