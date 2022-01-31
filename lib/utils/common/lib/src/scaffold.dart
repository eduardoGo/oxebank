import 'package:flutter/material.dart';

class GlobalScaffold {
  static Scaffold scaffoldApp({Widget? body, Widget? floatingActionButton}) =>
      Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(),
        body: body,
        floatingActionButton: floatingActionButton,
      );
}
