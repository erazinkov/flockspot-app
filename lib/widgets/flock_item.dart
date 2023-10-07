import 'package:flutter/material.dart';

import '../models/user.dart';

class FlockItem extends StatelessWidget {
  const FlockItem({
    super.key,
    required this.user,
    required this.onSelectUser,
  });

  final User user;
  final void Function() onSelectUser;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectUser,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        color: Color.fromRGBO(255, 255, 255, 0.05),
        child: Padding(
          padding: const EdgeInsets.all(16),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(16),
          //   gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [
          //       Colors.green.withOpacity(0.55),
          //       Colors.red.withOpacity(0.9),
          //     ],
          //   ),
          // ),
          // child: Text(
          //   user.firstName,
          //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
          //         color: Theme.of(context).colorScheme.onBackground,
          //       ),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ('lisbon artists').toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.circle),
                    iconSize: 10,
                  )
                ],
              ),
              SizedBox(
                height: 44,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Text(
                      'digital',
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: 48,
                      height: 48,
                      child: Image.asset(
                        'assets/images/photo-0.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                ('lisbon, portugal').toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(255, 255, 255, 0.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
