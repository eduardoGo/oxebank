import 'package:flutter/material.dart';
import 'package:openbank/loan/lib/src/loan_provider.dart';
import 'package:openbank/user/lib/api.dart';
import 'package:openbank/utils/constants/lib/src/text.dart';
import 'package:provider/provider.dart';
import 'package:openbank/utils/constants/lib/api.dart';

class Numbers extends StatefulWidget {
  const Numbers({Key? key}) : super(key: key);

  @override
  _NumbersState createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
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
    final loanProvider = context.watch<LoanProvider>();
    final values = loanProvider.activeLoans.map((e) => e.valueTotal).toList();
    return Container(
      color: const Color(0xFF474350),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'R\$ ${_user.balance + values.fold(0, (prev, curr) => (prev as double) + curr)},00',
                style: TextConstants.defaultTextStyle,
              ),
              Text(
                'Saldo c/c',
                style: TextConstants.defaultTextStyle,
              ),
            ],
          ),
          tenPercentSpaceBetweenHorizontal,
          Column(
            children: [
              Text(
                'R\$ ${_user.investmentBalance},00',
                style: TextConstants.defaultTextStyle,
              ),
              Text(
                'Saldo c/p',
                style: TextConstants.defaultTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
