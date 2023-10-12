import 'dart:convert';

import 'package:first_app/models/flock.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FlocksScreen extends StatefulWidget {
  const FlocksScreen({super.key});

  @override
  State<FlocksScreen> createState() => _FlocksScreenState();
}

class _FlocksScreenState extends State<FlocksScreen> {
  List<Flock> _flockItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _selectItem(BuildContext context, Flock flock) {
    _showInfoMessage('Flock ${flock.id} selected.');
  }

  void _loadItems() async {
    final url = Uri.parse('http://10.0.2.2:3000/api/flocks');
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data.';
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      List<Flock> listData = (json.decode(response.body) as List)
          .map((data) => Flock.fromJson(data))
          .toList();

      final List<Flock> loadedItems = [];

      for (final item in listData) {
        loadedItems.add(item);
      }

      setState(() {
        _flockItems = loadedItems;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Somethig went wrong.';
      });
    }
  }

  void _removeItem(Flock item) async {
    final index = _flockItems.indexOf(item);

    setState(() {
      _flockItems.remove(item);
    });

    final url = Uri.parse('http://10.0.2.2:3000/api/flocks/${item.id}');

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _flockItems.insert(index, item);
      });
    }
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
    if (_flockItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _flockItems.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            onDismissed: (direction) {
              _removeItem(_flockItems[index]);
            },
            key: ValueKey(_flockItems[index].id),
            child: Card(
                child: InkWell(
                    onTap: () {
                      _selectItem(context, _flockItems[index]);
                    },
                    splashColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                    borderRadius: BorderRadius.circular(16),
                    child: Card(
                        color: const Color.fromRGBO(255, 255, 255, 0.2),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Text(_flockItems[index].id.toString(),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer)),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(_flockItems[index].flockSize.toString(),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer)),
                            ],
                          ),
                        )))),
          );
        },
      );
    }

    if (_error != null) {
      content = Center(
        child: Text(
          _error!,
          style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
      );
    }

    return content;
  }
}
