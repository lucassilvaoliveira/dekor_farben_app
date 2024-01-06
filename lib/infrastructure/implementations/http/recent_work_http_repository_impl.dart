import 'package:dekor_farben_app/core/entities/recent_work.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_result/multiple_result.dart';

import '../../../global/routes/routes.dart';
import '../../../global/secure_storage.dart';

class RecentWorkHttpRepositoryImpl extends IBaseRepository<RecentWork> {

  @override
  Future<Result<List<RecentWork>, InfraException>> get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Result<RecentWork, InfraException>> getOne({required String? entityId}) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<Result<DataJsonObject, InfraException>> put({required RecentWork entity}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  Future<Result<List<RecentWork>, InfraException>> getAssets(
      {required List<RecentWork> recentWorks}) async {
    try {
      final jwt = await SecureStorage().readSecureData("jwt");

      for (var recentWork in recentWorks) {
        final uri = Uri.parse("${Routes.getRecentWorkAsset}${recentWork.id}");


        var anAssetResponse = await http.get(uri, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
          'Bearer $jwt',
        });

        if (anAssetResponse.statusCode == 200 || anAssetResponse.statusCode == 201) {
          recentWork.image = anAssetResponse.bodyBytes;
        }
      }

      return Success(recentWorks);
    } catch (error) {
      return Error(InfraException(cause: error.toString()));
    }
  }
}