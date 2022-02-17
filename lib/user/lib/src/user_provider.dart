import 'package:flutter/material.dart';

import 'user.dart';
import 'friend.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser;
  Friend? _choosedFriend;
  final List<User> users = [];

  bool get hasLoggedUser => _currentUser != null;

  User? get loggedUser => _currentUser;

  set currentUser(User user) => _currentUser = user;

  void chooseFriend(Friend choosedFriend) => _choosedFriend = choosedFriend;

  Friend? get choosedFriend => _choosedFriend;

  void addFriend(Friend friend) {
    _currentUser!.addFriend(friend);
    notifyListeners();
  }

  void removeFriend(Friend friend) {
    _currentUser!.removeFriend(friend);
    notifyListeners();
  }

  List<Friend> getAllFriends() =>
      _currentUser != null ? _currentUser!.getAllFriends() : [];

  void addBalanceMain(int value) {
    _currentUser!.addBalanceMain(value);
    notifyListeners();
  }

  void removeBalanceMain(int value) {
    _currentUser!.removeBalanceMain(value);
    notifyListeners();
  }

  void addBalanceInvestment(int value) {
    _currentUser!.addBalanceInvestment(value);
    notifyListeners();
  }

  void removeBalanceInvestment(int value) {
    _currentUser!.removeBalanceInvestment(value);
    notifyListeners();
  }
}
