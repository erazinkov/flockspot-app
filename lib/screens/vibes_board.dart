import 'package:first_app/models/vibe.dart';
import 'package:first_app/widgets/vibe_board_item.dart';
import 'package:flutter/material.dart';

class VibesBoard extends StatefulWidget {
  const VibesBoard({Key? key}) : super(key: key);

  @override
  _VibesBoardState createState() => _VibesBoardState();
}

class _VibesBoardState extends State<VibesBoard> {
  // final List<String> _unselected = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
  final List<Vibe> _unselected = [
    const Vibe(
      id: 0,
      name: 'digital',
      locations: [],
      events: [],
      places: [],
      users: [],
    ),
    const Vibe(
      id: 1,
      name: 'artists',
      locations: [],
      events: [],
      places: [],
      users: [],
    ),
    const Vibe(
      id: 2,
      name: 'spanish',
      locations: [],
      events: [],
      places: [],
      users: [],
    ),
    const Vibe(
      id: 0,
      name: 'hip-hop',
      locations: [],
      events: [],
      places: [],
      users: [],
    ),
    const Vibe(
      id: 1,
      name: 'yoga',
      locations: [],
      events: [],
      places: [],
      users: [],
    ),
    const Vibe(
      id: 2,
      name: 'dancing',
      locations: [],
      events: [],
      places: [],
      users: [],
    ),
  ];
  final List<Vibe> _selected = [];

  final _unselectedListKey = GlobalKey<AnimatedListState>();
  final _selectedListKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'add your first vibes'.toUpperCase(),
            style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.3),
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                // decoration: BoxDecoration(color: Colors.amber),
                child: Wrap(spacing: 8, runSpacing: 12, children: [
                  ..._selected.asMap().entries.map((entry) {
                    int idx = entry.key;
                    return GestureDetector(
                      key: Key(entry.value.name),
                      onTap: () {
                        setState(() {
                          _unselected.add(_selected[idx]);
                          _selected.remove(_selected[idx]);
                        });
                      },
                      child: VibeBoardItem(
                        vibe: entry.value,
                        showCloseIcon: true,
                      ),
                    );
                  })
                ]),
              ),
              const SizedBox(
                height: 76,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Type or Past Vibes',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                // decoration: BoxDecoration(color: Colors.amber),
                child: Wrap(spacing: 8, runSpacing: 12, children: [
                  ..._unselected.asMap().entries.map((entry) {
                    int idx = entry.key;
                    return GestureDetector(
                      onTap: () {
                        if (_selected.contains(_unselected[idx])) return;
                        setState(() {
                          _selected.add(_unselected[idx]);
                          _unselected.remove(_unselected[idx]);
                        });
                      },
                      child: Item(vibe: entry.value),
                    );
                  })
                ]),
              ),
            ],
          ),
        ));
  }

  int _flyingCount = 0;

  _moveItem({
    required int fromIndex,
    required List fromList,
    required GlobalKey<AnimatedListState> fromKey,
    required List toList,
    required GlobalKey<AnimatedListState> toKey,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    final globalKey = GlobalKey();
    final item = fromList.removeAt(fromIndex);
    fromKey.currentState!.removeItem(
      fromIndex,
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: Opacity(
            key: globalKey,
            opacity: 0.0,
            child: Item(vibe: item),
          ),
        );
      },
      duration: duration,
    );
    _flyingCount++;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // Find the starting position of the moving item, which is exactly the
      // gap its leaving behind, in the original list.
      final box1 = globalKey.currentContext!.findRenderObject() as RenderBox;
      final pos1 = box1.localToGlobal(Offset.zero);
      // Find the destination position of the moving item, which is at the
      // end of the destination list.
      final box2 = toKey.currentContext!.findRenderObject() as RenderBox;
      final box2height = box1.size.height * (toList.length + _flyingCount - 1);
      final pos2 = box2.localToGlobal(Offset(0, box2height));
      // Insert an overlay to "fly over" the item between two lists.
      final entry = OverlayEntry(builder: (BuildContext context) {
        return TweenAnimationBuilder(
          tween: Tween<Offset>(begin: pos1, end: pos2),
          duration: duration,
          builder: (_, Offset value, child) {
            return Positioned(
              left: value.dx,
              top: value.dy,
              child: Item(vibe: item),
            );
          },
        );
      });

      Overlay.of(context).insert(entry);
      await Future.delayed(duration);
      entry.remove();
      toList.add(item);
      toKey.currentState!.insertItem(toList.length - 1);
      _flyingCount--;
    });
  }
}

class Item extends StatelessWidget {
  const Item({Key? key, required this.vibe}) : super(key: key);

  final Vibe vibe;

  @override
  Widget build(BuildContext context) {
    return VibeBoardItem(
      vibe: vibe,
    );
  }
}

// class Item extends StatelessWidget {
//   final String text;

//   const Item({Key? key, required this.text}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: CircleAvatar(
//         child: Text(text),
//         radius: 24,
//       ),
//     );
//   }
// }
