import 'package:first_app/screens/user_details.dart';
import 'package:first_app/widgets/user_grid_item.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key, required this.users});

  final List<User> users;

  void _selectUser(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (ctx) => UserDetailsScreen(
                title: user.firstName,
                user: user,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        ...users.map(
          (user) {
            return UserGridItem(
              user: user,
              onSelectUser: () => _selectUser(context, user),
            );
          },
        )
        // for (final user in availableUsers)
        //   UserGridItem(user: user),
      ],
    );
  }
}
