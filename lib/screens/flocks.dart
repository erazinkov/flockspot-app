import 'package:first_app/data/dummy_data.dart';
import 'package:first_app/models/flock.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/models/vibe.dart';
import 'package:first_app/screens/flock.dart';
import 'package:first_app/widgets/flock_item.dart';
import 'package:first_app/widgets/vibe_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FlocksScreen extends StatefulWidget {
  const FlocksScreen({super.key});

  @override
  State<FlocksScreen> createState() => _FlocksScreenState();
}

class _FlocksScreenState extends State<FlocksScreen> {
  final List<Flock> _flockItems = dummyFlocks;
  final List<Vibe> _vibeItems = dummyVibes;

  void _loadItems() async {
    final url =
        Uri.parse('http://10.0.2.2:3000/api/flocks/paging?take=10&skip=0');

    final response = await http.get(url);

    print(response.body);
  }

  void _addItemUser() async {
    final url = Uri.parse('http://10.0.2.2:3000/api/users');
    final v = User(
      email: '123',
      firstName: '123',
      lastName: '123',
      dateOfBirth: DateTime.now(),
    );

    // final response = await http.post(url,
    //     headers: {
    //       'Content-type': 'application/json',
    //     },
    //     body: json.encode(v.toJson()));
    // print(response.body);
    // print(response.statusCode);
    print(json.encode(v.toJson()));
  }

  void _addItem() async {
    final url = Uri.parse('http://10.0.2.2:3000/api/vibes');
    final v = Vibe(
        name: 'Singing',
        status: VibeStatus.Approved,
        icon: 'string',
        users: []);

    final response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
        },
        body: json.encode(v.toJson()));
    print(response.body);
    print(response.statusCode);
    print(json.encode(v.toJson()));
  }

  @override
  void initState() {
    super.initState();
    // _addItemUser();
    // _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: _flockItems.length,
      itemBuilder: (ctx, index) {
        return Dismissible(
          key: ValueKey(_flockItems[index].id),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => FlockScreen(
                  flock: _flockItems[index],
                ),
              ));
            },
            child: FlockItem(flock: _flockItems[index]),
          ),
        );
      },
    );

    return content;
  }
}
