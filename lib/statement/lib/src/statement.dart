import 'package:openbank/utils/user/lib/api.dart';

class Statement {
  static String getStatementMonth(User user) =>
      'Extrato bancário do ${user.name}';
}
