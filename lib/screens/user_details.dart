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
    Widget content = SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...widget.user.photos.asMap().entries.map(
                    (entry) {
                      int index = entry.key;
                      return GestureDetector(
                        onTap: () {
                          _selectActive(index);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          width: 65,
                          height: 65,
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: MemoryImage(kTransparentImage),
                            image: NetworkImage(widget.user.photos[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                FadeInImage(
                  // fit: BoxFit.cover,
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(widget.user.photos[activeIndex]),
                ),
                Positioned(
                  child: Container(
                    width: double.infinity,
                    color: Colors.black54,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
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
          Text('Vibes block'),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: content,
    );
  }
}
