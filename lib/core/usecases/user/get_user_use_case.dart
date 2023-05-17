import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infraestructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetUserUseCase {
  final IBaseRepository<User> repository;

  GetUserUseCase({required this.repository});

  Future<Result<List<User>, InfraException>> call() async {
    return await repository.get();
  }
}
