// ignore_for_file: constant_identifier_names

import 'user.dart';

enum KEYS { CPF, EMAIL, CELLPHONE, ALLEATORY_KEY }

class Friend {
  Friend(this.name, {User? user});

  String name;
  User? user;
  KEYS? _choosedPixKey;
  String? _choosedTedKey;

  final Map<KEYS, String> _pixKeys = {};

  final Map<String, Map<String, String>> _tedKeys = {};

  set choosePixKey(KEYS key) {
    _choosedPixKey = key;
    _choosedTedKey = null;
  }

  set chooseTedKey(String key) {
    _choosedTedKey = key;
    _choosedPixKey = null;
  }

  KEYS? get choosedPixKey => _choosedPixKey;

  String? get choosedTedKey => _choosedTedKey;

  void addPixKey(KEYS type, String key) => _pixKeys[type] = key;

  String getKey(KEYS type) => _pixKeys.containsKey(type) ? _pixKeys[type]! : '';

  Map<KEYS, String> getAllPixKeys() => _pixKeys;

  void addTedKey(
          {required String bankCode,
          required String agency,
          required String account}) =>
      _tedKeys.addAll({
        bankCode: {agency: account}
      });

  Map<String, String> getTedKey({required String codeBank}) =>
      _tedKeys.containsKey(codeBank) ? _tedKeys[codeBank]! : <String, String>{};

  Map<String, Map<String, String>> getAllTedKeys() => _tedKeys;
}

KEYS convertFromString(String key) {
  switch (key) {
    case 'Chave aleatória':
      return KEYS.ALLEATORY_KEY;
    case 'Celular':
      return KEYS.CELLPHONE;
    case 'CPF':
      return KEYS.CPF;
    case 'Email':
      return KEYS.EMAIL;
    default:
      return KEYS.ALLEATORY_KEY;
  }
}

String convertFromKEY(KEYS key) {
  switch (key) {
    case KEYS.ALLEATORY_KEY:
      return 'Chave aleatória';
    case KEYS.CELLPHONE:
      return 'Celular';
    case KEYS.CPF:
      return 'CPF';
    case KEYS.EMAIL:
      return 'Email';
  }
}
