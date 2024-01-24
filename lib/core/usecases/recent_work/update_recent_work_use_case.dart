import 'dart:io';

import 'package:multiple_result/multiple_result.dart';

import '../../../helpers/data_json_object.dart';
import '../../../helpers/infra_exception.dart';
import '../../../infrastructure/contracts/i_base_repository.dart';
import '../../../infrastructure/implementations/http/recent_work_http_repository_impl.dart';
import '../../entities/recent_work.dart';

class UpdateRecentWorkUseCase {
  final IBaseRepository<RecentWork> repository;

  UpdateRecentWorkUseCase({required this.repository});

  Future<Result<DataJsonObject, InfraException>> call({required RecentWork recentWork, required File file}) async {
    if (repository is RecentWorkHttpRepositoryImpl) {
      final repositoryImpl = repository as RecentWorkHttpRepositoryImpl;
      return await repositoryImpl.update(entity: recentWork, image: file);
    } else {
      return Future.error(InfraException(cause: "Could not complete operation"));
    }
  }
}