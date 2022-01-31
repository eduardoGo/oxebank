import 'package:flutter/material.dart';
import 'package:openbank/communication/lib/src/communication.dart';
import 'package:openbank/home/lib/src/services.dart';
import 'package:openbank/utils/constants/lib/src/text.dart';
import 'package:openbank/utils/user/lib/api.dart';
import 'package:openbank/utils/user/lib/src/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:openbank/utils/constants/lib/api.dart';
import 'package:openbank/utils/common/lib/api.dart';
import 'pre_home_view.dart';
import 'services.dart';
import 'profile.dart';
import 'numbers.dart';

const bool debug = true;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var isReady = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final onePercentSpaceBetweenVertical =
        SizedBox(height: screenSize.height * 0.01);
    return GlobalScaffold.scaffoldApp(
      body: !isReady
          ? const PreHomeView()
          : Column(
              children: <Widget>[
                const ProfileView(),
                onePercentSpaceBetweenVertical,
                const Numbers(),
                const Services(),
              ],
            ),
    );
  }

  void initData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!context.read<UserProvider>().hasLoggedUser) return;
    isReady = true;
    setState(() {});
  }
}
