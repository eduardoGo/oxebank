import 'package:openbank/utils/user/lib/api.dart';
import 'package:flutter/material.dart';

class Communication extends ChangeNotifier {
  late User? _user;

  bool login({required String cpf, required String password}) {
    // Request the user data to server using the cpf and password.
    // Build the [User] class based on response.

    //FakeUser
    _user = User(
        name: 'Eduardo Gomes dos Santos',
        cpf: '123.456.789-99',
        agency: '0001',
        account: '456123-1');

    notifyListeners();

    return true;
  }

  User? get currentUser => _user;
}
