import 'dart:async';

import 'package:first_app/models.dart';
import 'package:first_app/requests.dart';

class AlbumBLoC {
  // Stream<Album> get album async* {
  //   yield await AlbumService().fetchAlbum();
  // }

  // Stream<Album> get album async* {
  //   while (true) {
  //     await Future.delayed(const Duration(seconds: 3));
  //     yield await AlbumService().fetchAlbum();
  //   }
  // }

  Stream<Album> get album => Stream.periodic(Duration(milliseconds: 1000))
      .asyncMap((event) async => await AlbumService().fetchAlbum());

  final StreamController _data = StreamController();

  AlbumBLoC() {
    album.listen(
      (event) => _data.add(event),
    );
  }
}
