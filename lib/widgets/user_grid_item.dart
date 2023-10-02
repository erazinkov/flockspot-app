import 'dart:math';

import 'package:flutter/material.dart';

import '../models/user.dart';

class UserGridItem extends StatelessWidget {
  const UserGridItem({
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
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: SweepGradient(
            colors: [
              Colors.pink.withOpacity(0.55),
              Colors.pink.withOpacity(0.9),
            ],
          ),
        ),
        child: Text(
          user.firstName,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
