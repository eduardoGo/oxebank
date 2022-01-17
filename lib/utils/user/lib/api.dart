class User {
  User(
      {required String name,
      required String cpf,
      required String agency,
      required String account})
      : _name = name,
        _cpf = cpf,
        _agency = agency,
        _account = account;

  final String _name;
  final String _cpf;
  final String _agency;
  final String _account;

  get name => _name;
  get cpf => _cpf;
  get agency => _agency;
  get account => _account;
}
