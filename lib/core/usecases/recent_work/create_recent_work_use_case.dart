import 'dart:io';

import 'package:dekor_farben_app/core/entities/recent_work.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/recent_work_http_repository_impl.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../helpers/data_json_object.dart';
import '../../../helpers/infra_exception.dart';
import '../../../infrastructure/contracts/i_base_repository.dart';

class CreateRecentWorkUseCase {
  final IBaseRepository<RecentWork> repository;

  CreateRecentWorkUseCase({required this.repository});

  Future<Result<DataJsonObject, InfraException>> call({required RecentWork recentWork, required File file}) async {
    if (repository is RecentWorkHttpRepositoryImpl) {
      final repositoryImpl = repository as RecentWorkHttpRepositoryImpl;
      return await repositoryImpl.create(entity: recentWork, image: file);
    } else {
      return Future.error(InfraException(cause: "Could not complete operation"));
    }
  }
}