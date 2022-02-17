import 'dart:math';

import 'package:flutter/material.dart';
import 'package:openbank/loan/lib/src/loan.dart';
import 'package:openbank/loan/lib/src/loan_provider.dart';
import 'package:openbank/user/lib/api.dart';
import 'package:provider/provider.dart';

class LoanView extends StatefulWidget {
  const LoanView({Key? key}) : super(key: key);

  @override
  _LoanViewState createState() => _LoanViewState();
}

class _LoanViewState extends State<LoanView> {
  int value = 0;
  int months = 1;

  final textStyleInfos = const TextStyle(
    fontFamily: 'PT-Sans',
    fontSize: 16,
    // fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    final avaliableLoan = userProvider.loggedUser!.balance * 3;

    final futureValue =
        value > avaliableLoan ? 0 : value * pow(1 + 0.015, months);

    final loanProvider = context.watch<LoanProvider>();

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
                    'Empréstimo',
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
                    hintText: 'Digite o valor que deseja',
                    obscureText: false,
                    inputResult: (input) =>
                        setState(() => value = int.parse(input as String)),
                    prefixedIcon: const Icon(
                      Icons.attach_money,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Tempo (meses)',
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
                    hintText:
                        'Digite a quantidade de meses em que deseja pagar',
                    obscureText: false,
                    inputResult: (input) => setState(() {
                      final intInput = int.parse(input as String);
                      months = intInput > 1 ? intInput : 1;
                    }),
                    prefixedIcon: const Icon(
                      Icons.timelapse,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Valor disponível para empréstimo: R\$ $avaliableLoan',
                      style: textStyleInfos,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Quantidade de meses: $months',
                      style: textStyleInfos,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pagamento mensal: ${(futureValue / months).toStringAsFixed(2)}',
                      style: textStyleInfos,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pagamento total: R\$ ${futureValue.toStringAsFixed(2)}',
                      style: textStyleInfos,
                    ),
                  ),
                  const SizedBox(height: 30),
                  FinishButton(
                    onPressed: value < avaliableLoan
                        ? () {
                            loanProvider.addLoan(
                              Loan(
                                valueTotal: value.toDouble(),
                                months: months,
                              ),
                            );
                            Navigator.of(context).pop();
                          }
                        : () => null,
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
          'Finalizar',
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
