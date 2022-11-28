
class Validations {

  Validations._();

  static name(String? text) {
    if (text == null || text.length < 3) {
      return 'mínimo 3 caracteres';
    }
  }

  static String? email(String? value) {
    value ??= "";
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) return null;
    return 'email inválido';
  }

  static String? password(String? text) {
    if (text == null || text.length < 5) {
      return 'mínimo 5 caracteres';
    }
    return null;
  }

  static String? confirmPassword(String pass, String? confirmPass) {
    if (confirmPass == null) {
      return 'mínimo 5 caracteres';
    } else if (pass != confirmPass) {
        return 'senhas diferentes';
    }
    return null;
  }
  
}