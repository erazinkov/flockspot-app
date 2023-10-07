import 'package:first_app/screens/user_details.dart';
import 'package:first_app/widgets/flock_item.dart';
import 'package:first_app/widgets/user_grid_item.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class FlocksScreen extends StatelessWidget {
  const FlocksScreen({super.key, required this.users, required this.onRemove});

  final List<User> users;
  final void Function(User user) onRemove;

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
    void showInfoMessage(String message) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text(message),
      ));
    }

    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: users.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(users[index]),
        onDismissed: (direction) {
          onRemove(users[index]);
        },
        child: FlockItem(
          user: users[index],
          onSelectUser: () => _selectUser(context, users[index]),
        ),
      ),
    );
    // return GridView(
    //   padding: EdgeInsets.all(16),
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     childAspectRatio: 3 / 2,
    //     crossAxisSpacing: 20,
    //     mainAxisSpacing: 20,
    //   ),
    //   children: [
    //     ...users.map(
    //       (user) {
    //         return UserGridItem(
    //           user: user,
    //           onSelectUser: () => _selectUser(context, user),
    //         );
    //       },
    //     )
    //   ],
    // );
  }
}
