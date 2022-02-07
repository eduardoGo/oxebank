import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openbank/communication/lib/api.dart';
import 'package:openbank/utils/constants/lib/api.dart';
import 'package:openbank/utils/user/lib/api.dart';
import 'package:openbank/utils/user/lib/src/user_provider.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? nomeCompleto;
  String? cpf;
  String? password;

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    final communication = context.read<Communication>();

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
                    'Novo usuário',
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
                      'Nome completo',
                      style: TextStyle(
                        fontFamily: 'PT-Sans',
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  InputField(
                    hintText: 'Seu nome completo',
                    obscureText: false,
                    inputResult: (input) => nomeCompleto = input,
                    prefixedIcon: const Icon(
                      Icons.perm_identity_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'CPF',
                      style: TextStyle(
                        fontFamily: 'PT-Sans',
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  InputField(
                    hintText: 'Digite seu CPF',
                    obscureText: false,
                    inputResult: (input) => cpf = input,
                    prefixedIcon: const Icon(
                      Icons.format_indent_decrease,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Senha',
                      style: TextStyle(
                        fontFamily: 'PT-Sans',
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  InputField(
                    hintText: 'Digite sua nova senha',
                    obscureText: true,
                    inputResult: (input) => password = input,
                    prefixedIcon: const Icon(
                      Icons.password,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  FinishButton(
                    onPressed: () {
                      print('pressed with $nomeCompleto');
                      if (nomeCompleto != null &&
                          cpf != null &&
                          password != null) {
                        communication.createUser(
                          userProvider,
                          User(
                            name: nomeCompleto!,
                            cpf: cpf!,
                            agency: (List.generate(
                                4, (_) => (Random()).nextInt(100))).toString(),
                            account: (List.generate(
                                6, (_) => (Random()).nextInt(100))).toString(),
                          ),
                        );
                        Navigator.of(context).pop();
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
