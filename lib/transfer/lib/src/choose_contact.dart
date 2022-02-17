import 'package:flutter/material.dart';
import 'package:openbank/utils/common/lib/api.dart';
import 'package:openbank/utils/constants/lib/api.dart';
import 'package:openbank/utils/constants/lib/src/text.dart';
import 'package:openbank/user/lib/api.dart';
import 'package:provider/provider.dart';

import 'transfer_key.dart';

class ChooseContact extends StatefulWidget {
  const ChooseContact({Key? key}) : super(key: key);

  @override
  State<ChooseContact> createState() => _ChooseContactState();
}

class _ChooseContactState extends State<ChooseContact> {
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    print("DEBUG userProvider INSTANCE: ${userProvider.hashCode}");
    final friends = userProvider.getAllFriends();
    print("DEBUG AMIGOS ATUAIS: $friends");
    final names = friends.map((e) => e.name).toList();

    return GlobalScaffold.scaffoldApp(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Selecione o contato',
              style: TextConstants.defaultTextStyle,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(
                      names[index],
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    leading: const Icon(Icons.mobile_friendly),
                    onTap: () {
                      userProvider.chooseFriend(friends[index]);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const TransferKey()),
                      );
                    },
                    // trailing: Icon(icons[index]),
                  ));
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          tooltip: 'Adicionar contato',
          onPressed: () => Navigator.of(context)
              .pushNamed('/addContact')
              .then((value) => setState(() {})),
          child: const Icon(Icons.add, color: Colors.black, size: 35),
        ));
  }
}
