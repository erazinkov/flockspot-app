import 'dart:async';

import 'package:first_app/bloc.dart';
import 'package:first_app/models.dart';
import 'package:first_app/requests.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;
  AlbumBLoC albumBLoC = AlbumBLoC();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: albumBLoC.album,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              }
              return const CircularProgressIndicator();
            },
          ),
          // child: FutureBuilder<Album>(
          //   future: futureAlbum,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return Text(snapshot.data!.title);
          //     } else if (snapshot.hasError) {
          //       return Text('${snapshot.error}');
          //     }

          //     // By default, show a loading spinner.
          //     return const CircularProgressIndicator();
          //   },
          // ),
        ),
      ),
    );
  }
}
