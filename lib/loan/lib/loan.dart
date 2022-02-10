// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:openbank/communication/lib/api.dart';
// import 'package:openbank/utils/user/lib/src/user_provider.dart';
// import 'package:provider/provider.dart';

// import '../../utils/common/lib/api.dart';
// import '../../utils/constants/lib/api.dart';

// class Loan extends StatefulWidget {
//   @override
//   const Loan({Key? key}) : super(key: key);

//   @override
//   State<Loan> createState() => _LoanState();
// }

// class _LoanState extends State<Loan> {
//   @override
//   Widget build(BuildContext context) {

//     return GlobalScaffold.scaffoldApp(

//         floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.white,
//         tooltip: 'Fazer Empréstimo',
//         onPressed: () => Navigator.of(context)
//           .pushNamed('/Loan')
//           .then((value) => setState(() {})),
//         child: const Icon(Icons.add, color: Colors.black, size: 35),
//         ));

//   }
// }