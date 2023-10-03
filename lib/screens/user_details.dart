import 'package:first_app/data/dummy_data.dart';
import 'package:first_app/widgets/vibes.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/user.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.user,
    required this.title,
  });

  final User user;
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _UserDetailsScreen();
  }
}

class _UserDetailsScreen extends State<UserDetailsScreen> {
  var activeIndex = 0;
  void _selectActive(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(children: [
      SizedBox(
        height: 44,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.user.photo!.split(',').asMap().length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _selectActive(index);
              },
              child: Container(
                width: 44,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(widget.user.photo!.split(',')[index]),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            width: 4,
          ),
        ),
      ),
      Expanded(
        child: Stack(
          alignment: Alignment.center,
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(widget.user.photo!.split(',')[activeIndex]),
            ),
            Positioned(
              child: Container(
                width: double.infinity,
                color: Colors.black54,
                margin: EdgeInsets.all(44),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                child: Text(
                  '${widget.user.firstName} ${widget.user.lastName}',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      const Vibes(vibes: dummyVibes),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: content,
    );
  }
}
