import 'package:flutter/material.dart';
import 'home/home_view.dart';
import 'login/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open bank',
      theme: ThemeData(
        primarySwatch: MaterialColor(Colors.black.value, <int, Color>{
          50: const Color(0xFF000000),
          100: const Color(0xFF000000),
          200: const Color(0xFF000000),
          300: const Color(0xFF000000),
          400: const Color(0xFF000000),
          500: Color(Colors.black.value),
          600: const Color(0xFF000000),
          700: const Color(0xFF000000),
          800: const Color(0xFF000000),
          900: const Color(0xFF000000),
        }),
      ),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Center(
      //       child: Text('Open Bank'),
      //     ),
      //   ),
      //   body: const LoginScreen(),
      // ),
      home: const LoginScreen(),
    );
  }
}
