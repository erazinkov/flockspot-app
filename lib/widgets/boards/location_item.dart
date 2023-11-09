import 'package:first_app/widgets/boards/chip_number.dart';
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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(255, 255, 255, 0.2),
          image: DecorationImage(
            image: Image.network(
              'https://via.placeholder.com/600/5e3a73',
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
                    styles: ChipNumberStyles.user(),
                  ),
                ],
                const SizedBox(
                  width: 8,
                ),
                ChipNumber(
                  number: location.flocks!.length,
                  styles: ChipNumberStyles.flock(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
