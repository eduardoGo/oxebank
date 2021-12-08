import 'package:flutter/material.dart';

class Home3View extends StatelessWidget {
  const Home3View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: const Text("Profile space"),
            color: Colors.green,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            child: const Text("Numbers space"),
            color: Colors.blue,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: const Text("Features space"),
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenSize.height * 0.1,
              width: screenSize.width,
              child: const Text("Profile space"),
              color: Colors.green,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenSize.height * 0.2,
              width: screenSize.width,
              child: const Text("Numbers space"),
              color: Colors.blue,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // height: screenSize.height * 0.61,
              width: screenSize.width,
              child: const Text("Features space"),
              color: Colors.grey,
            ),
          ],
        )
      ],
    );
  }
}
