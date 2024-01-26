import 'package:dekor_farben_app/infrastructure/contracts/i_login_repository.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../helpers/data_json_object.dart';
import '../../../helpers/infra_exception.dart';

class AuthUseCase {
  final ILoginRepository repository;

  AuthUseCase({required this.repository});

  Future<Result<DataJsonObject, InfraException>> call({
    required String email,
    required String password
  }) async {
    return await repository.call(email: email, password: password);
  }
}