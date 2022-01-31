import 'package:flutter/material.dart';
import 'package:openbank/statement/lib/api.dart';
import 'package:openbank/utils/constants/lib/api.dart';
import 'package:openbank/utils/user/lib/api.dart';
import 'package:openbank/communication/lib/api.dart';
import 'package:openbank/utils/user/lib/src/user_provider.dart';
import 'package:provider/provider.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
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
    final onePercentSpaceBetweenVertical =
        SizedBox(height: screenSize.height * 0.05);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            IconButton(
              onPressed: () {
                print(Statement.getStatementMonth(_user));
              },
              icon: const Icon(
                Icons.format_list_numbered,
                color: Colors.yellow,
              ),
            ),
            const Text(
              'Extrato',
              style: TextConstants.defaultTextStyle,
            ),
            onePercentSpaceBetweenVertical,
            IconButton(
              onPressed: () {
                print('Investir');
              },
              icon: const Icon(
                Icons.money,
                color: Colors.yellow,
              ),
            ),
            const Text(
              'Investir',
              style: TextConstants.defaultTextStyle,
            ),
          ],
        ),
        tenPercentSpaceBetweenHorizontal,
        Column(
          children: [
            IconButton(
              onPressed: () {
                print(Statement.getStatementMonth(_user));
              },
              icon: const Icon(
                Icons.payment,
                color: Colors.yellow,
              ),
            ),
            const Text(
              'Pagamentos',
              style: TextConstants.defaultTextStyle,
            ),
            onePercentSpaceBetweenVertical,
            IconButton(
              onPressed: () {
                print('Empréstimo');
              },
              icon: const Icon(
                Icons.attach_money,
                color: Colors.yellow,
              ),
            ),
            const Text(
              'Empréstimo',
              style: TextConstants.defaultTextStyle,
            ),
          ],
        ),
        tenPercentSpaceBetweenHorizontal,
        Column(
          children: [
            IconButton(
              onPressed: () {
                print('Transfer');
                Navigator.pushNamed(context, '/choose_contact',
                    arguments: _user.getAllFriends());
              },
              icon: const Icon(
                Icons.transfer_within_a_station,
                color: Colors.yellow,
              ),
            ),
            const Text(
              'Transferências',
              style: TextConstants.defaultTextStyle,
            ),
            // onePercentSpaceBetweenVertical,
            // IconButton(
            //   onPressed: () {
            //     print('Transfer');
            //     Navigator.pushNamed(context, '/choose_contact',
            //         arguments: _user.getAllFriends());
            //   },
            //   icon: const Icon(
            //     Icons.people,
            //     color: Colors.yellow,
            //   ),
            // ),
            // const Text(
            //   'Amigos',
            //   style: TextConstants.defaultTextStyle,
            // )
          ],
        )
      ],
    );
  }
}
