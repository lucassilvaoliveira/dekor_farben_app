import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CreateUserUseCase {
  final IBaseRepository<User> repository;

  CreateUserUseCase({required this.repository});

  Future<Result<DataJsonObject, InfraException>> call({required User? user}) async {
    if (user != null) {
      return await repository.put(entity: user);
    }
    return Error(InfraException(cause: "'user' cannot be null!"));
  }
}
