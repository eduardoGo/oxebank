import 'package:openbank/user/lib/api.dart';

class Statement {
  static String getStatementMonth(User user) =>
      'Extrato bancário do ${user.name}';
}
