mixin ValidationMixins {
  //Se esta vazio
  String? insNotEmpty(String? value, [String? message]) {
    if (value!.trim().isEmpty) {
      return message ?? 'Please, make sure to fill all fields.';
    }
    return null;
  }

  String? isValidPhone(String? value, [String? message]) {
    if (value!.length != 9) {
      return message ?? 'Please, that you have entered 9 digits.';
    }
    return null;
  }

  String? multiValidator(String? value, [String? message]) {
    //? Check the minimium password length
    if (value!.length < 6) {
      return message ??
          'Sorry, your passowrd should have more than 6 characteres.';
    }

    //? Check if its easy
    if (value.contains('123456') ||
        value.contains('1234') ||
        value.contains('0000') ||
        value.contains('000000')) {
      return message ?? 'Please make sure to provide a password strong enough.';
    }

    //? Special character
    var caracteresEspeciais = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (!caracteresEspeciais.hasMatch(value)) {
      return message ??
          'Your Password should have at least 1 special character';
    }

    //? Check if it has number
    var numeros = RegExp(r'[0-9]');
    if (!numeros.hasMatch(value)) {
      return message ?? 'Your password should have at least one number';
    }
    return null;
    /* 
  //? Check if it has capital letters 
  var letrasMaiusculas = RegExp(r'[A-Z]');
  if (!letrasMaiusculas.hasMatch(value)) return 'Your password should have at least one capital letter.';

   //? Check if it has small letters
  var letrasMinusculas = RegExp(r'[a-z]');
  if (!letrasMinusculas.hasMatch(value)) return 'Your password should have at least one small letter.';
*/
  }

  String? validateEmail(String? value, [String? message]) {
    //? Check if email format is valid
    var formatoEmail = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!formatoEmail.hasMatch(value!)) {
      return message ?? 'Please insert a valid email address.';
    }
    return null;
  }

  //Retornar todas validacoes
  String? combineValidators(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }
    return null;
  }
}
