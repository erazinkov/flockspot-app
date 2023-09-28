import 'package:flutter/material.dart';

class PhotosList extends StatelessWidget {
  const PhotosList({
    super.key,
    required this.photos,
    required this.selectPhoto,
  });
  final List<String> photos;

  final void Function(int index) selectPhoto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...photos.asMap().entries.map(
              (entry) {
                int index = entry.key;
                String photo = entry.value;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Opacity(
                    opacity: 0.5,
                    child: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      icon: Image.asset(
                        width: 55,
                        height: 55,
                        photo,
                        fit: BoxFit.cover,
                      ),
                      onPressed: () {
                        selectPhoto(index);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
