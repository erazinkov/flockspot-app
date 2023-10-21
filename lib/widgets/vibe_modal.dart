import 'dart:ui';

import 'package:flutter/material.dart';

class VibeModal extends StatelessWidget {
  const VibeModal({
    super.key,
    required this.name,
    this.icon,
    this.background,
    required this.description,
  });

  final String name;
  final String? icon;
  final String? background;
  final String description;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(alignment: Alignment.center, children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(background!),
              ),
            ),
            width: screenSize.width,
            height: 0.8 * screenSize.width,
          ),
          Container(
            width: screenSize.width,
            height: 0.8 * screenSize.width,
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.black,
                    ],
                    stops: const [
                      0.0,
                      1.0
                    ])),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(255, 255, 255, 0.2)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Text(
                  name,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 56,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ]),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'about topic'.toUpperCase(),
                style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.3),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                description,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        )
      ],
      // children: [
      //   Container(
      //     width: screenSize.width,
      //     height: 0.8 * screenSize.width,
      //     decoration: const BoxDecoration(
      //         gradient: LinearGradient(
      //             begin: Alignment.topLeft,
      //             end: Alignment.bottomRight,
      //             colors: [
      //           Color.fromRGBO(112, 0, 254, 0.59),
      //           Color.fromRGBO(143, 90, 255, 0.66),
      //           Color.fromRGBO(23, 5, 74, 0),
      //         ])),
      //     child: NetworkImage(url),
      //   ),
      // ],
    );
  }
}
