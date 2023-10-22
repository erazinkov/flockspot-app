import 'package:first_app/models/flock.dart';
import 'package:first_app/screens/flock.dart';
import 'package:first_app/services/api_service.dart';
import 'package:first_app/widgets/flock_item.dart';
import 'package:flutter/material.dart';

class FlocksScreen extends StatefulWidget {
  const FlocksScreen({super.key});

  @override
  State<FlocksScreen> createState() => _FlocksScreenState();
}

class _FlocksScreenState extends State<FlocksScreen> {
  var _isLoading = true;
  late List<Flock> _loadedItems = [];

  void _loadItems() async {
    _loadedItems = (await ApiService().getFlocks())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _isLoading = false;
        }));
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'No items...',
        style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
    if (_isLoading) {
      content = Center(
        child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onPrimaryContainer),
      );
    }
    if (_loadedItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _loadedItems.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            key: ValueKey(_loadedItems[index].id),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => FlockScreen(
                    flock: _loadedItems[index],
                  ),
                ));
              },
              child: FlockItem(flock: _loadedItems[index]),
            ),
          );
        },
      );
    }
    return content;
  }
}
