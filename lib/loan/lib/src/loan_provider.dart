import 'package:flutter/material.dart';

import 'loan.dart';

class LoanProvider extends ChangeNotifier {
  final List<Loan> _activeLoans = [];

  List<Loan> get activeLoans => _activeLoans;

  void addLoan(Loan loan) {
    _activeLoans.add(loan);
    notifyListeners();
  }
}
