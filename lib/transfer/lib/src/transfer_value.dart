import 'package:flutter/material.dart';
import 'package:openbank/utils/debug/lib/flags.dart';
import 'package:openbank/user/lib/api.dart';
import 'package:openbank/communication/lib/api.dart';
import 'package:provider/provider.dart';

class TransferValue extends StatefulWidget {
  const TransferValue({Key? key}) : super(key: key);

  @override
  _TransferValueState createState() => _TransferValueState();
}

class _TransferValueState extends State<TransferValue> {
  int value = 0;
  final textStyleInfos = const TextStyle(
    fontFamily: 'PT-Sans',
    fontSize: 16,
    // fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    final externalCommunication = context.watch<Communication>();

    final userProvider = context.watch<UserProvider>();
    // userProvider.chooseFriend(Friend('Any name'));
    final choosedFriend = userProvider.choosedFriend!;
    // choosedFriend.choosedTedKey = '125';
    // choosedFriend.addTedKey(
    //     bankCode: '125', agency: '1265-1', account: '154687-1');
    // choosedFriend.addPixKey(KEYS.EMAIL, 'egs@laccan.ufal.br');
    // choosedFriend.choosedPixKey = KEYS.EMAIL;

    final choosedKeyIsTed = choosedFriend.choosedPixKey == null;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.black,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ).copyWith(top: 60),
              child: Column(
                children: [
                  const Text(
                    'Insira o valor desejado para transferência',
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 30,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Valor',
                      style: TextStyle(
                        fontFamily: 'PT-Sans',
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    hintText: 'Valor para transferência',
                    obscureText: false,
                    inputResult: (input) => value = int.parse(input as String),
                    prefixedIcon: const Icon(
                      Icons.villa_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text('Destinatário',
                        style: TextStyle(
                          fontFamily: 'PT-Sans',
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nome: ${choosedFriend.name}',
                      style: textStyleInfos,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Modo de transferência: ${choosedKeyIsTed ? 'TED' : 'PIX'}',
                      style: textStyleInfos,
                    ),
                  ),
                  const SizedBox(height: 5),
                  if (!choosedKeyIsTed)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Chave: ${choosedFriend.getKey(choosedFriend.choosedPixKey!)}',
                        style: textStyleInfos,
                      ),
                    ),
                  if (choosedKeyIsTed)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Banco: ${choosedFriend.choosedTedKey!}',
                        style: textStyleInfos,
                      ),
                    ),
                  if (choosedKeyIsTed) const SizedBox(height: 5),
                  if (choosedKeyIsTed)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Agência: ${choosedFriend.getTedKey(codeBank: choosedFriend.choosedTedKey!).keys.first}',
                        style: textStyleInfos,
                      ),
                    ),
                  if (choosedKeyIsTed)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Conta: ${choosedFriend.getTedKey(codeBank: choosedFriend.choosedTedKey!).values.first}',
                        style: textStyleInfos,
                      ),
                    ),
                  const SizedBox(height: 30),
                  FinishButton(
                    onPressed: () {
                      if (choosedKeyIsTed) {
                        final temp = choosedFriend.getTedKey(
                          codeBank: choosedFriend.choosedTedKey!,
                        );

                        externalCommunication.sendTransferTed(
                          choosedFriend.choosedTedKey!,
                          temp.keys.first,
                          temp.values.first,
                          value,
                        );
                      } else {
                        externalCommunication.sendTransferPix(
                            choosedFriend.getKey(choosedFriend.choosedPixKey!),
                            value);
                      }
                      if (AppConfig.debugMode)
                        userProvider.removeBalanceMain(value);
                      print('pressed with $value');
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                    // if (cpf != null && password != null) {
                    //   context
                    //       .read<userProvider>()
                    //       .login(cpf: cpf!, password: password!);
                    //   Navigator.pushNamedAndRemoveUntil(
                    //       context, '/home', (route) => false);
                    // }
                    ,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    TextInputType inputType = TextInputType.number,
    required Function(Object) inputResult,
  })  : _obscureText = obscureText,
        _prefixedIcon = prefixedIcon,
        _hintText = hintText,
        _inputType = inputType,
        _inputResult = inputResult,
        super(key: key);

  final bool _obscureText;
  final Widget? _prefixedIcon;
  final String? _hintText;
  final TextInputType _inputType;
  final Function(Object) _inputResult;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 2,
      child: TextField(
        keyboardType: _inputType,
        cursorColor: Colors.white,
        cursorWidth: 2,
        obscureText: _obscureText,
        style: const TextStyle(color: Colors.white),
        onChanged: _inputResult,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.transparent,
          prefixIcon: _prefixedIcon,
          hintText: _hintText,
          hintStyle: const TextStyle(
            color: Colors.white54,
            // fontWeight: FontWeight.bold,
            fontFamily: 'PTSans',
          ),
        ),
      ),
    );
  }
}

class FinishButton extends StatelessWidget {
  const FinishButton({
    Key? key,
    required Function() onPressed,
  })  : _onPressed = onPressed,
        super(key: key);

  final Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
          elevation: MaterialStateProperty.all(6),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        child: const Text(
          'Enviar',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            // fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onPressed: _onPressed,
      ),
    );
  }
}
