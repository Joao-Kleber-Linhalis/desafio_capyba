class AuthException implements Exception {
  static const Map<String, String> errors = {
    'invalid-credential': 'E-mail e/ou senha incorretos.',
    'user-disabled': 'Esta conta foi desativada.',
    'email-already-in-use': 'Este e-mail já está em uso.',
    'operation-not-allowed': 'Operação não permitida.',
    'too-many-requests': 'Muitas tentativas. Tente novamente mais tarde.',
    'user-not-found': 'Usuário não encontrado.',
    'wrong-password': 'Senha incorreta.',
    'invalid-email': 'E-mail inválido.',
    'weak-password': 'A senha é muito fraca.',
    'network-request-failed': 'Falha na conexão. Verifique sua internet.',
    'requires-recent-login': 'É necessário fazer login novamente.',
    'account-exists-with-different-credential':
        'Já existe uma conta com este e-mail.',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro no processo de autenticação';
  }
}
