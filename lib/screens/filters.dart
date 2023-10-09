import 'package:flutter/material.dart';

enum Filter {
  one,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<StatefulWidget> createState() {
    return _FiltersScreen();
  }
}

class _FiltersScreen extends State<FiltersScreen> {
  var _oneFilterSet = false;

  @override
  void initState() {
    super.initState();
    _oneFilterSet = widget.currentFilters[Filter.one]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('your filters'.toUpperCase()),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.one: _oneFilterSet,
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _oneFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _oneFilterSet = isChecked;
                });
              },
              title: Text(
                'Filter 1',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              subtitle: Text(
                'Description 1',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              inactiveThumbColor: Theme.of(context).colorScheme.onPrimary,
              inactiveTrackColor: Theme.of(context).colorScheme.primary,
              activeColor: Theme.of(context).colorScheme.onPrimaryContainer,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
