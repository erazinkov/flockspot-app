import 'dart:async';

import 'package:first_app/services/api_service.dart';
import 'package:flutter/material.dart';

class StreamBuilderAuth extends StatefulWidget {
  const StreamBuilderAuth({super.key});

  @override
  State<StreamBuilderAuth> createState() => _StreamBuilderAuthState();
}

class _StreamBuilderAuthState extends State<StreamBuilderAuth> {
  final Stream<String?> _credentials = (() {
    late final StreamController<String?> controller;
    controller = StreamController<String?>(
      onListen: () async {
        await Future<void>.delayed(const Duration(seconds: 1));
        String? response =
            await ApiService.authLogin('test@mail.com', 'Password1');
        controller.add(response);
        await Future<void>.delayed(const Duration(seconds: 5));
        await controller.close();
      },
    );
    return controller.stream;
  })();

  @override
  Widget build(BuildContext context) {
    String? str;
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: Container(
        alignment: FractionalOffset.center,
        color: Colors.white,
        child: StreamBuilder<String?>(
          stream: _credentials,
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            List<Widget> children;
            if (snapshot.hasError) {
              children = <Widget>[Text(snapshot.hasError.toString())];
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  children = <Widget>[
                    Text(snapshot.connectionState.toString())
                  ];
                case ConnectionState.waiting:
                  children = const <Widget>[Text('Waiting')];
                case ConnectionState.active:
                  {
                    if (snapshot.data != null) {
                      str = snapshot.data;
                      children = const <Widget>[
                        Text('Active'),
                      ];
                    }
                    children = const <Widget>[
                      CircularProgressIndicator(),
                    ];
                  }
                case ConnectionState.done:
                  children = <Widget>[
                    Text(
                      str ?? 'Done',
                      maxLines: 2,
                    )
                  ];
              }
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            );
          },
        ),
      ),
    );
  }
}
