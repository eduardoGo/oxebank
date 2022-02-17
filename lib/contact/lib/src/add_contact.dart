import 'package:flutter/material.dart';
import 'package:openbank/user/lib/api.dart';
import 'package:provider/provider.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  String? friendName;
  String dropdownValue = 'Email';
  String? chavePix;

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();

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
                    'Adicionar contato',
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
                      'Nome',
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
                    hintText: 'Nome do seu amigo',
                    obscureText: false,
                    inputResult: (input) => friendName = input,
                    inputType: TextInputType.name,
                    prefixedIcon: const Icon(
                      Icons.perm_identity_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Chave pix',
                      style: TextStyle(
                        fontFamily: 'PT-Sans',
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                              chavePix = '';
                            });
                          },
                          items: <String>[
                            'Email',
                            'Celular',
                            'Chave aleatória',
                            'CPF'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        // width: MediaQuery.of(context).size.width * 0.45,
                        child: dropdownValue != 'Chave aleatória'
                            ? InputField(
                                hintText: 'Digite a chave pix ($dropdownValue)',
                                obscureText: false,
                                inputType:
                                    correspondentInputType(dropdownValue),
                                inputResult: (input) => chavePix = input,
                                prefixedIcon: const Icon(
                                  Icons.perm_identity_rounded,
                                  color: Colors.white,
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 10),
                  // InputField(
                  //   inputResult: (input) => password = input,
                  //   hintText: 'Enter your password',
                  //   obscureText: true,
                  //   prefixedIcon: const Icon(Icons.lock, color: Colors.white),
                  // ),
                  const SizedBox(height: 15),
                  FinishButton(
                    onPressed: () {
                      print('pressed with $friendName');
                      if (friendName != null &&
                          userProvider.hasLoggedUser &&
                          (chavePix != null ||
                              dropdownValue.contains('Chave'))) {
                        Friend newFriend = Friend(friendName!);

                        newFriend.addPixKey(
                            convertFromString(dropdownValue),
                            !dropdownValue.contains('Chave')
                                ? chavePix!
                                : 'jkasdh7812y3as564da5');
                        userProvider.addFriend(newFriend);
                        if (!Navigator.of(context).canPop())
                          print('CANNOT POP');
                        Navigator.of(context).pop();
                      } else {
                        print(
                          'DEBUG: friendName: $friendName, hasLloggedUser: ${userProvider.hasLoggedUser}, chavePix: $chavePix, dropValue: $dropdownValue',
                        );
                      }
                      // if (cpf != null && password != null) {
                      //   context
                      //       .read<userProvider>()
                      //       .login(cpf: cpf!, password: password!);
                      //   Navigator.pushNamedAndRemoveUntil(
                      //       context, '/home', (route) => false);
                      // }
                    },
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

TextInputType correspondentInputType(String type) {
  if (type == 'Email') {
    print('HERE');
    return TextInputType.emailAddress;
  } else {
    return TextInputType.number;
  }
}

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    TextInputType inputType = TextInputType.number,
    required Function(String) inputResult,
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
  final Function(String) _inputResult;

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
          'Adicionar',
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
