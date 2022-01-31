import 'package:flutter/material.dart';
import 'package:openbank/communication/lib/src/communication.dart';
import 'package:openbank/utils/constants/lib/src/text.dart';
import 'package:openbank/utils/user/lib/api.dart';
import 'package:openbank/utils/user/lib/src/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:openbank/utils/constants/lib/api.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = context.read<UserProvider>().loggedUser!;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final tenPercentSpaceBetweenHorizontal =
        SizedBox(width: screenSize.width * 0.1);

    return SizedBox(
      width: screenSize.width,
      height: screenSize.height * 0.10,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        alignment: Alignment.center,
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.pink,
              radius: 50.0,
              backgroundImage: AssetImage('assets/profile/default_icon.png'),
            ),
            tenPercentSpaceBetweenHorizontal,
            Column(
              children: [
                Text(
                  _user.name,
                  style: TextConstants.defaultTextStyle,
                ),
                Text(
                  'Agência: ' + _user.agency + '\nConta: ' + _user.account,
                  style: TextConstants.defaultTextStyle,
                ),
              ],
            ),
            tenPercentSpaceBetweenHorizontal,
            const Text(
              'OxeBank',
              style: TextConstants.defaultTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
