import 'package:flutter/material.dart';
import 'package:openbank/communication/lib/api.dart';
import 'package:openbank/home/lib/api.dart';
import 'package:openbank/login/lib/api.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Communication>(
          create: (_) => Communication(),
        ),
      ],
      child: MaterialApp(
        title: 'Oxe bank',
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
          textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.white)),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const DefaultTextStyle(
                style: TextStyle(color: Colors.white, fontSize: 30),
                child: HomeView(),
              ),
        },
        home: const LoginScreen(),
      ),
    );
  }
}
