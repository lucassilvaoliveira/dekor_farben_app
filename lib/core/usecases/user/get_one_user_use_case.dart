import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetOneUserUseCase {
  final IBaseRepository<User> repository;

  GetOneUserUseCase({required this.repository});

  Future<Result<User, InfraException>> call({required String userId}) async {
    return await repository.getOne(entityId: userId);
  }
}
