import 'package:first_app/models/user.dart';
import 'package:first_app/models/vibe.dart';
import 'package:first_app/services/api_service.dart';
import 'package:first_app/utils/local_storage.dart';
import 'package:first_app/utils/parse_jwt.dart';
import 'package:first_app/widgets/vibe_board_item.dart';
import 'package:flutter/material.dart';

class VibesBoard extends StatefulWidget {
  const VibesBoard({Key? key}) : super(key: key);

  @override
  _VibesBoardState createState() => _VibesBoardState();
}

class _VibesBoardState extends State<VibesBoard> {
  var _isLoading = true;
  late List<Vibe> _loadedItems = [];
  late List<Vibe> _unSelected = [];
  final List<Vibe> _selected = [];

  void _loadItems() async {
    _unSelected = (await ApiService().getVibes())!;
    Future.delayed(const Duration(seconds: 3)).then((value) => setState(() {
          _isLoading = false;
        }));
    // _unSelected = _loadedItems;
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    Widget contentUnSelected = Center(
      child: Text(
        'No items...',
        style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
    if (_isLoading) {
      contentUnSelected = Center(
        child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onPrimaryContainer),
      );
    }
    if (_unSelected.isNotEmpty) {
      contentUnSelected = SizedBox(
          width: double.infinity,
          child: Wrap(spacing: 8, runSpacing: 12, children: [
            ..._unSelected.asMap().entries.map((entry) {
              int idx = entry.key;
              return GestureDetector(
                onTap: () {
                  if (_selected.contains(_unSelected[idx])) return;
                  setState(() {
                    _selected.add(_unSelected[idx]);
                    _unSelected.remove(_unSelected[idx]);
                  });
                },
                child: Item(vibe: entry.value),
              );
            })
          ]));
    }
    Widget contentButton = Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        GestureDetector(
          onTap: () async {
            final String? apiToken =
                await getStringFromLocalStorage('apiToken');
            var id = parseJwt(apiToken!)['id'];
            List<int> selectedIdxs = [];
            for (var s in _selected) {
              selectedIdxs.add(s.id!.toInt());
            }
            await ApiService().patchUser(
                id,
                User(
                    email: 'test@email.com',
                    firstName: 'testuser',
                    lastName: 'testuser',
                    vibes: selectedIdxs));

            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (ctx) => NextPage(),
            // ));
          },
          child: Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromRGBO(255, 255, 255, 0.2)),
              child: Text(
                'Continue',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              )),
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'add your first vibes'.toUpperCase(),
            style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.3),
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Wrap(spacing: 8, runSpacing: 12, children: [
                  ..._selected.asMap().entries.map((entry) {
                    int idx = entry.key;
                    return GestureDetector(
                      key: Key(entry.value.name),
                      onTap: () async {
                        // final String? apiToken =
                        //     await getStringFromLocalStorage('apiToken');
                        // var v = parseJwt(apiToken!);
                        // print(v);
                        setState(() {
                          _unSelected.add(_selected[idx]);
                          _selected.remove(_selected[idx]);
                        });
                      },
                      child: VibeBoardItem(
                        vibe: entry.value,
                        isSelected: true,
                      ),
                    );
                  })
                ]),
              ),
              const SizedBox(
                height: 76,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Type or Past Vibes',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              contentUnSelected,
              if (_selected.isNotEmpty) contentButton,
            ],
          ),
        ));
  }
}

class Item extends StatelessWidget {
  const Item({Key? key, required this.vibe}) : super(key: key);

  final Vibe vibe;

  @override
  Widget build(BuildContext context) {
    return VibeBoardItem(
      vibe: vibe,
    );
  }
}
