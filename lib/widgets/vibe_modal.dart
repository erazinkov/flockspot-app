import 'dart:ui';

import 'package:flutter/material.dart';

class VibeModal extends StatefulWidget {
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
  State<VibeModal> createState() => _VibeModalState();
}

class _VibeModalState extends State<VibeModal> {
  var _showFullText = false;
  double _turns = 0.0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    Widget text = Text(
      //description,
      'Hip hop or hip-hop, also known as rap, and formerly known as disco rap, is a genre of popular music that originated in the early 1970s by African Americans.',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontSize: 20,
          fontWeight: FontWeight.w400),
    );

    Widget fullText = Text(
      //description,
      'Hip hop or hip-hop, also known as rap, and formerly known as disco rap, is a genre of popular music that originated in the early 1970s by African Americans.',
      style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontSize: 20,
          fontWeight: FontWeight.w400),
    );

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: Column(
        children: [
          Stack(alignment: Alignment.center, children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(24), topEnd: Radius.circular(24)),
                color: Colors.transparent,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.background!),
                ),
              ),
              width: screenSize.width,
              height: 0.8 * screenSize.width,
            ),
            Container(
              width: screenSize.width,
              height: 0.8 * screenSize.width,
              decoration: BoxDecoration(
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
                      color: const Color.fromRGBO(255, 255, 255, 0.2)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Text(
                    widget.name,
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
            // width: double.infinity,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 500),
                      crossFadeState: _showFullText
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: fullText,
                      secondChild: text,
                    )),
                    Expanded(
                      flex: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showFullText = !_showFullText;
                            _turns += 1.0 / 2.0;
                          });
                        },
                        child: AnimatedRotation(
                          turns: _turns,
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 0.1),
                                borderRadius: BorderRadius.circular(24)),
                            child: ImageIcon(
                              size: 16,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              const AssetImage('assets/icons/flock.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromRGBO(255, 255, 255, 0.1)),
                  child: const Text(
                    'to add upgrade account',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
