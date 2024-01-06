import 'package:multiple_result/multiple_result.dart';

class Validators {

  static bool isNotNullableAttributeValid(final Object? aValue) {
    if (aValue != null && (aValue is String && aValue.isNotEmpty)) {
      return true;
    }

    return false;
  }

  static Result<void, String> nameValidator(final String aName) {
    bool isFullName(String name) {
      List<String> words = name.split(" ")
          .where((word) => word.isNotEmpty)
          .toList();
      return words.length >= 2;
    }

    if (!isNotNullableAttributeValid(aName)) {
      return Result.error("O campo 'Nome' deve ser informado");
    }

    if (!isFullName(aName)) {
      return Result.error("Informe um nome completo");
    }

    return Result.success(null);
  }

  static Result<void, String> emailValidator(final String anEmail) {
    if (!isNotNullableAttributeValid(anEmail)) {
      return Result.error("O campo 'Email' deve ser informado");
    }

    final bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(anEmail);

    if (!emailValid) {
      return Result.error("Informe um email válido"'');
    }

    return Result.success(null);
  }

  static Result<void, String> cpfValidator(final String aCpf) {
    if (!isNotNullableAttributeValid(aCpf)) {
      return Result.error("O campo 'CPF' deve ser informado");
    }

    final cpfFormatted = aCpf
        .replaceAll(".", "")
        .replaceAll("-", "");

    if (!_isCPF(cpfFormatted)) {
      return Result.error("Deve ser informado um CPF válido");
    }

    return Result.success(null);
  }

  static Result<void, String> cnpjValidator(final String aCnpj) {
    if (!isNotNullableAttributeValid(aCnpj)) {
      return Result.error("O campo 'CNPJ' deve ser informado");
    }

    final numbers = aCnpj.replaceAll(RegExp(r'[^0-9]'), '');

    if (!_isCNPJ(numbers)) {
      return Result.error("Deve ser informado um CNPJ válido");
    }

    return Result.success(null);
  }

  static Result<void, String> birthDayValidator(final String aBirthday) {
    if (!isNotNullableAttributeValid(aBirthday)) {
      return Result.error("O campo 'Data de nascimento' deve ser informado");
    }

    final bool birthdayCorrectFormatValid = RegExp(
        "^([0-2][0-9]|3[0-1])/(0[1-9]|1[0-2])/[0-9]{4}"
    ).hasMatch(aBirthday);

    if (!birthdayCorrectFormatValid) {
      return Result.error("Informe uma data no formato correto (dd/MM/yyyy)");
    }

    return Result.success(null);
  }

  static Result<void, String> telephoneValidator(final String aPhone) {
    if (!isNotNullableAttributeValid(aPhone)) {
      return Result.error("O campo 'Telefone' deve ser informado");
    }

    return Result.success(null);
  }

  static Result<void, String> passwordValidator(final String aPassword) {
    const String numberDigitRegex = ".*[0-9].*";
    const String lowercaseRegex = ".*[a-z].*";
    const String uppercaseRegex = ".*[A-Z].*";
    const String specialCharactersRegex = ".*[!@#&()–{}:;',?/*~\$^+=<>].*";
    const String atLeast8Characters = "^.{8,}\$";

    if (!isNotNullableAttributeValid(aPassword)) {
      return Result.error("O campo 'Senha' deve ser informado");
    }

    if (!RegExp(numberDigitRegex).hasMatch(aPassword)) {
      return Result.error("A senha deve conter pelo menos 1 número");
    }

    if (!RegExp(lowercaseRegex).hasMatch(aPassword)) {
      return Result.error("A senha deve conter letras minúsculas");
    }

    if (!RegExp(uppercaseRegex).hasMatch(aPassword)) {
      return Result.error("A senha deve conter letras maiúsculas");
    }

    if (!RegExp(specialCharactersRegex).hasMatch(aPassword)) {
      return Result.error("A senha deve conter pelo menos 1 caractere especial");
    }

    if (!RegExp(atLeast8Characters).hasMatch(aPassword)) {
      return Result.error("A senha deve conter pelo menos 8 caracteres");
    }

    return Result.success(null);
  }
}

bool _isCPF(final String aCpf) {
  final bool notCpf = aCpf == '00000000000' ||
      aCpf == '11111111111' ||
      aCpf == '22222222222' || aCpf == '33333333333' ||
      aCpf == '44444444444' || aCpf == '55555555555' ||
      aCpf == '66666666666' || aCpf == '77777777777' ||
      aCpf == '88888888888' || aCpf == '99999999999' ||
      aCpf.length != 11;

  if (notCpf) {
    return false;
  }

  final firstDigit = _validateFirstDigit(aCpf);
  final secondDigit = _validateSecondDigit(aCpf);

  return firstDigit == aCpf[9] && secondDigit == aCpf[10];
}

bool _isCNPJ(final String cnpj) {
  var numbers = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
  if (numbers.length != 14) return false;

  String cnpjBase = numbers.substring(0, 12);

  List<int> cnpjBaseDigits = cnpjBase.split('').map(int.parse).toList();
  List<int> cnpjDigits = numbers.split('').map(int.parse).toList();

  int sum1 = 0;
  int sum2 = 0;

  final weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  final weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  for (int i = 0; i < 12; i++) {
    sum1 += cnpjBaseDigits[i] * weights1[i];
    sum2 += cnpjDigits[i] * weights2[i];
  }

  int remainder1 = sum1 % 11;
  int calculatedDigit1 = remainder1 < 2 ? 0 : 11 - remainder1;

  if (calculatedDigit1 != cnpjDigits[12]) return false;

  sum2 += calculatedDigit1 * weights2[12];

  int remainder2 = sum2 % 11;
  int calculatedDigit2 = remainder2 < 2 ? 0 : 11 - remainder2;

  if (calculatedDigit2 != cnpjDigits[13]) return false;

  return true;
}

String _validateFirstDigit(String aCpf) {
  int totalSum = 0;
  int weight = 10;

  for (int i = 0; i < 9; i++) {
    int number = aCpf.codeUnitAt(i) - 48;
    totalSum += number * weight;
    weight--;
  }

  int result = 11 - (totalSum % 11);
  if (result == 10 || result == 11) {
    return '0';
  } else {
    return String.fromCharCode(result + 48);
  }
}

String _validateSecondDigit(String aCpf) {
  int totalSum = 0;
  int weight = 11;

  for (int i = 0; i < 10; i++) {
    int number = aCpf.codeUnitAt(i) - 48;
    totalSum += number * weight;
    weight--;
  }

  int result = 11 - (totalSum % 11);
  if (result == 10 || result == 11) {
    return '0';
  } else {
    return String.fromCharCode(result + 48);
  }
}