import 'package:flutter/material.dart';

class Photos extends StatelessWidget {
  const Photos({
    super.key,
    required this.photos,
    required this.switchPhoto,
  });
  final List<String> photos;

  final void Function(int index) switchPhoto;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        ...photos.asMap().entries.map(
          (entry) {
            int index = entry.key;
            String photo = entry.value;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.rectangle,
                  ),
                  child: TextButton(
                    onPressed: () {
                      switchPhoto(index);
                    },
                    child: Text(photo),
                  )),
            );
          },
        ),
      ]),
    );
  }
}
