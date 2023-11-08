import 'dart:ui';

import 'package:flutter/material.dart';

class VibeModal extends StatefulWidget {
  const VibeModal({
    super.key,
    this.name,
    this.icon,
    this.background,
    this.description,
  });

  final String? name;
  final String? icon;
  final String? background;
  final String? description;

  @override
  State<VibeModal> createState() => _VibeModalState();
}

class _VibeModalState extends State<VibeModal> {
  bool _showFull = false;
  double _turns = 0.0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    Widget description = Text(
      widget.description ?? 'No description for this vibe.',
      maxLines: !_showFull ? 2 : null,
      overflow: !_showFull ? TextOverflow.ellipsis : null,
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.black,
                  ],
                ),
              ),
              width: screenSize.width,
              height: 0.8 * screenSize.width,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                child: Image.network(
                  widget.background ?? '',
                  fit: BoxFit.fill,
                  errorBuilder: (context, exception, stackTrace) {
                    return const Text('');
                  },
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10.0,
                  sigmaY: 10.0,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.2)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Text(
                    widget.name ?? '',
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
                      crossFadeState: _showFull
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: description,
                      secondChild: description,
                    )),
                    Expanded(
                      flex: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showFull = !_showFull;
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
