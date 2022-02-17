import 'package:flutter/material.dart';
import 'package:openbank/loan/lib/src/loan_provider.dart';
import 'package:openbank/utils/common/lib/api.dart';
import 'package:openbank/utils/constants/lib/api.dart';
import 'package:provider/provider.dart';

class ListLoansView extends StatefulWidget {
  const ListLoansView({Key? key}) : super(key: key);

  @override
  _ListLoansViewState createState() => _ListLoansViewState();
}

class _ListLoansViewState extends State<ListLoansView> {
  @override
  void initState() {
    super.initState();
    context.read<LoanProvider>().addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final loans = context.watch<LoanProvider>();
    final loansValue = loans.activeLoans.map((e) => e.valueTotal).toList();
    final loansMonths = loans.activeLoans.map((e) => e.months).toList();

    return GlobalScaffold.scaffoldApp(
        body: loansValue.isEmpty
            ? const Align(
                alignment: Alignment(0, -0.3),
                child: Text(
                  'Não há empréstimos :)',
                  style: TextConstants.defaultTextStyle,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Empréstimos em andamento',
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
                      itemCount: loansValue.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          title: Text(
                            'Valor total: R\$ ${loansValue[index]}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                          subtitle: Text(
                            'Tempo restante: ${loansMonths[index]} meses',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                          leading: const Icon(Icons.attach_money_outlined),
                          onTap: null,
                          // trailing: Icon(icons[index]),
                        ));
                      },
                    ),
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          tooltip: 'Novo empréstimo',
          onPressed: () => Navigator.of(context).pushNamed('/new_loan'),
          child: const Icon(Icons.add, color: Colors.black, size: 35),
        ));
  }
}
