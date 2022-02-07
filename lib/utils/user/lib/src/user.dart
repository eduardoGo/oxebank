// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

import 'friend.dart';

class User extends ChangeNotifier {
  User({
    required String name,
    required String cpf,
    required String agency,
    required String account,
  })  : _name = name,
        _cpf = cpf,
        _agency = agency,
        _account = account;

  final String _name;
  final String _cpf;
  final String _agency;
  final String _account;
  final List<Friend> _friends = [];
  double _balanceMainAccount = 0;
  double _balanceInvestmentAccount = 0;

  get name => _name;
  get cpf => _cpf;
  get agency => _agency;
  get account => _account;

  void addFriend(Friend friend) {
    _friends.add(friend);
    notifyListeners();
  }

  void removeFriend(Friend friend) => _friends.remove(friend);

  List<Friend> getAllFriends() => _friends;

  double get balance => _balanceMainAccount;

  double get investmentBalance => _balanceInvestmentAccount;

  void addBalanceMain(int value) {
    if (value > 0) _balanceMainAccount += value;
  }

  void removeBalanceMain(int value) {
    if (value > 0 && (_balanceMainAccount - value) >= 0)
      _balanceMainAccount -= value;
  }

  void addBalanceInvestment(int value) {
    if (value > 0) _balanceInvestmentAccount += value;
  }

  void removeBalanceInvestment(int value) {
    if (value > 0 && (_balanceInvestmentAccount - value) >= 0)
      _balanceInvestmentAccount -= value;
  }
}
