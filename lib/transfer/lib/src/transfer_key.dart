import 'package:flutter/material.dart';
import 'package:openbank/utils/common/lib/api.dart';
import 'package:openbank/utils/constants/lib/api.dart';
import 'package:openbank/utils/constants/lib/src/text.dart';
import 'package:openbank/utils/user/lib/src/friend.dart';
import 'package:openbank/communication/lib/api.dart';
import 'package:openbank/utils/user/lib/api.dart';
import 'package:openbank/utils/user/lib/src/user_provider.dart';
import 'package:provider/provider.dart';

class TransferKey extends StatefulWidget {
  const TransferKey({Key? key}) : super(key: key);

  @override
  State<TransferKey> createState() => _TransferKeyState();
}

class _TransferKeyState extends State<TransferKey> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userProvider = context.read<UserProvider>();

    userProvider.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    final friend = userProvider.choosedFriend!;

    final titles = friend
        .getAllPixKeys()
        .entries
        .map((entry) => '${convertFromKEY(entry.key)}: ${entry.value}')
        .toList();

    final keys = friend
        .getAllPixKeys()
        .entries
        .map((entry) => convertFromKEY(entry.key))
        .toList();

    final subtitles =
        friend.getAllPixKeys().entries.map((entry) => 'PIX').toList();

    subtitles.addAll(friend.getAllTedKeys().keys.map((e) => 'TED').toList());
    final titlesTed = friend
        .getAllTedKeys()
        .entries
        .map((entry) =>
            'Banco: ${entry.key} Agência: ${entry.value.keys.first} Conta: ${entry.value.values.first}')
        .toList();

    titles.addAll(titlesTed);

    keys.addAll(friend.getAllTedKeys().keys.toList());

    return GlobalScaffold.scaffoldApp(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Selecione a chave',
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
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    // leading: Text('leading'),
                    title: Text(
                      titles[index],
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    subtitle: Text(
                      subtitles[index],
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 10),
                    ),
                    // trailing: Text('trailing'),
                    onTap: () {
                      if (subtitles[index] == 'PIX') {
                        friend.choosePixKey = convertFromString(keys[index]);
                      } else {
                        friend.chooseTedKey = keys[index];
                      }
                      Navigator.of(context).pushNamed('/transfer_value');
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
          onPressed: () => Navigator.of(context).pushNamed('/addContact'),
          child: const Icon(Icons.add, color: Colors.black, size: 35),
        ));
  }
}
