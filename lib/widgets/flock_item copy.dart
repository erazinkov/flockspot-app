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
        color: Color.fromARGB(20, 255, 255, 255),
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
          child: Text(
            user.firstName,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
      ),
    );
  }
}
