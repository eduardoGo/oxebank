import 'package:openbank/utils/debug/lib/flags.dart';
import 'package:openbank/utils/user/lib/api.dart';
import 'package:flutter/material.dart';
import 'package:openbank/utils/user/lib/src/user_provider.dart';

class Communication extends ChangeNotifier {
  bool login(UserProvider userProvider,
      {required String cpf, required String password}) {
    // Request the user data to server using the cpf and password.
    // Build the [User] class based on response.

    if (AppConfig.debugMode) {
      //FakeUser
      final fakeUser = User(
          name: 'Eduardo Gomes dos Santos',
          cpf: '123.456.789-99',
          agency: '0001',
          account: '456123-1');

      fakeUser.addBalanceInvestment(1236);
      fakeUser.addBalanceMain(859);

      final fakeFriend = Friend('Dudu Gomes');
      fakeFriend.addPixKey(KEYS.CELLPHONE, '82981228599');
      fakeFriend.addPixKey(KEYS.EMAIL, 'egs1@ic.ufal.br');
      fakeFriend.addTedKey(
          bankCode: '192', agency: '000001', account: '165454-9');
      fakeFriend.addTedKey(
          bankCode: '249', agency: '1246-9', account: '54879-9');

      fakeUser.addFriend(fakeFriend);

      userProvider.currentUser = fakeUser;
    }
    notifyListeners();

    return true;
  }

  Future<bool> sendTransferTed(
      String code, String agency, String account, int value) async {
    await Future.delayed(const Duration(seconds: 1));
    print("Transferência TED realizada com sucesso"
        "\n$code, $agency, $account, valor: $value");
    print("Atualizando usuário... Requisição para o servidor...");
    return true;
  }

  Future<bool> sendTransferPix(String key, int value) async {
    await Future.delayed(const Duration(seconds: 1));
    print("Transferência PIX realizada com sucesso\n$key, valor: $value");
    print("Atualizando usuário... Requisição para o servidor...");
    return true;
  }
}
