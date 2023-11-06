import 'dart:async';

import 'package:first_app/models.dart';
import 'package:first_app/requests.dart';

class AlbumBLoC {
  // Stream<Album> get album async* {
  //   yield await AlbumService().fetchAlbum();
  // }

  Stream<Album> get album async* {
    yield await AlbumService().fetchAlbum();
  }

  final StreamController<Album> _data = StreamController<Album>();

  Stream<Album> get data => _data.stream;

  AlbumBLoC() {
    album.listen(
      (event) => _data.add(event),
    );
  }
}
