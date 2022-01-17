// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:openbank/communication/lib/src/communication.dart';
import 'package:openbank/utils/user/lib/api.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var isReady = false;

  late User _user;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final horizontalSpaceBetween = SizedBox(width: screenSize.width * 0.1);
    final verticalSpaceBetween = SizedBox(height: screenSize.height * 0.01);
    const defaultTextStyle = TextStyle(color: Colors.white, fontSize: 20);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: !isReady
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Loding...\nPlease wait',
                  style: defaultTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: screenSize.width * 0.5,
                    height: screenSize.height * 0.50,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                      color: Colors.white,
                      strokeWidth: 10,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: <Widget>[
                SizedBox(
                  width: screenSize.width,
                  height: screenSize.height * 0.10,
                  // decoration: BoxDecoration(color: Colors.black),
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.pink,
                          radius: 50.0,
                          // maxRadius: 50,
                          // minRadius: 10,
                          backgroundImage:
                              AssetImage('assets/profile/default_icon.png'),
                        ),
                        horizontalSpaceBetween,
                        Column(
                          children: [
                            Text(_user.name, style: defaultTextStyle),
                            Text(
                                'Bank number: ' +
                                    _user.agency +
                                    '\nAccount: ' +
                                    _user.account,
                                style: defaultTextStyle),
                          ],
                        ),
                        horizontalSpaceBetween,
                        Text('OxeBank', style: defaultTextStyle),
                      ],
                    ),
                  ),
                ),
                verticalSpaceBetween,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: screenSize.height * 0.2,
                      width: screenSize.width,
                      child: const Text("Numbers space (TODO)"),
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
                      child: const Text("Features space (TODO)"),
                      color: Colors.grey,
                    ),
                  ],
                )
              ],
            ),
    );
  }

  void initData() {
    //DEBUG
    context.read<Communication>().login(cpf: '123', password: '123');
    if (context.read<Communication>().currentUser == null) return;
    _user = context.read<Communication>().currentUser!;
    isReady = true;
  }
}
