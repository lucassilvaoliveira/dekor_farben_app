import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_login_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class LoginUseCase {
  final ILoginRepository repository;

  LoginUseCase({required this.repository});

  Future<Result<DataJsonObject, InfraException>> call({required String? email, required String? password}) async {
    if (email != null && password != null) {
      return await repository.call(email: email, password: password);
    }
    return Error(InfraException(cause: "'email' or 'password' cannot be null!"));
  }
}
