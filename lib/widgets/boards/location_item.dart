import 'package:first_app/widgets/vibe_item.dart';
import 'package:first_app/widgets/vibe_modal.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/location.dart';

class LocationItem extends StatelessWidget {
  const LocationItem({
    super.key,
    required this.location,
  });

  final Location location;

  @override
  Widget build(BuildContext context) {
    final int n = location.users!.length < 4 ? location.users!.length : 4;
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(255, 255, 255, 0.2),
          image: DecorationImage(
            image: Image.network(
              'https://via.placeholder.com/200/9e59da',
              errorBuilder: (context, exception, stackTrace) {
                return const Text('');
              },
            ).image,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Wrap(spacing: 0, runSpacing: 0, children: [
                ...location.vibes!.asMap().entries.map((entry) {
                  int idx = entry.key;
                  return GestureDetector(
                    key: Key(entry.value.id.toString()),
                    onTap: () async {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Wrap(children: [
                            VibeModal(
                              name: location.vibes![idx].name,
                              description: location.vibes![idx].description,
                              background: location.vibes![idx].background,
                            ),
                          ]);
                        },
                      );

                      // setState(() {
                      //   _unSelected.add(_selected[idx]);
                      //   _selected.remove(_selected[idx]);
                      // });
                    },
                    child: VibeItem(
                      vibe: entry.value,
                    ),
                  );
                })
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                for (int i = 0; i < n; i++) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.5,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage:
                          NetworkImage(location.users![i].photo!.split(',')[0]),
                    ),
                  ),
                ],
                const SizedBox(
                  width: 16,
                ),
                if (location.users!.length > 4) ...[
                  ChipNumber(
                    number: location.users!.length - 4,
                    type: ChipNumberType.user,
                  ),
                ],
                const SizedBox(
                  width: 8,
                ),
                ChipNumber(
                  number: location.flocks!.length,
                  type: ChipNumberType.flock,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum ChipNumberType {
  user,
  flock,
}

class ChipNumber extends StatelessWidget {
  const ChipNumber({
    super.key,
    required this.number,
    required this.type,
  });

  final int number;
  final ChipNumberType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: (type == ChipNumberType.flock ? 4 : 12),
          top: 4,
          right: 4,
          bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: type == ChipNumberType.flock
            ? const Color.fromRGBO(255, 151, 54, 1)
            : Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type == ChipNumberType.flock ? '$number' : '+$number',
            style: const TextStyle(
              height: 1.0,
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (type == ChipNumberType.flock) ...[
            const SizedBox(
              width: 4,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: Text(
                'flocks'.toUpperCase(),
                style: const TextStyle(
                  height: 1.0,
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
