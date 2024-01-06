
import 'package:dekor_farben_app/core/entities/recent_work.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../helpers/infra_exception.dart';
import '../../../infrastructure/implementations/http/recent_work_http_repository_impl.dart';

class GetRecentWorkAssetUseCase {
  final IBaseRepository<RecentWork> repository;

  GetRecentWorkAssetUseCase({required this.repository});

  Future<Result<List<RecentWork>, InfraException>> call({required List<RecentWork> recentWorks}) async {
    if (repository is RecentWorkHttpRepositoryImpl) {
      final repositoryImpl = repository as RecentWorkHttpRepositoryImpl;

      final Result<List<RecentWork>, InfraException> response
      = await repositoryImpl.getAssets(recentWorks: recentWorks);

      if (response.isSuccess()) {
        return Success(recentWorks);
      } else {
        return Error(InfraException(cause: "Could no complete operation"));
      }
    } else {
      return Future.error(InfraException(cause: "Could complete operation"));
    }
  }
}