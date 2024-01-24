import 'dart:convert';
import 'dart:io';

import 'package:dekor_farben_app/core/entities/recent_work.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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

  Future<Result<DataJsonObject, InfraException>> create({required RecentWork entity, required File image}) async {
    final createBody = {
      "company_id": entity.companyId,
      "date": "${entity.recentWorkDate.toIso8601String()}Z",
      "is_active": true
    };

    final jwt = await SecureStorage().readSecureData("jwt");

    final request = await http.post(
      Uri.parse(Routes.recentWorks),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $jwt"
      },
      body: jsonEncode(createBody),
    );

    if (request.statusCode == 201) {
      final created = {
        "id": jsonDecode(request.body)["id"]
      };

      await _updateAsset(anId: jsonDecode(request.body)["id"], aFile: image);

      return Result.success(DataJsonObject(status: 201, body: created));
    }

    return Result.error(InfraException(cause: "Could not create recent work: ${request.body}"));
  }

  Future<Result<DataJsonObject, InfraException>> update({required RecentWork entity, required File image}) async {
    final createBody = {
      "company_id": entity.companyId,
      "date": "${entity.recentWorkDate.toIso8601String()}Z",
      "is_active": true
    };

    final jwt = await SecureStorage().readSecureData("jwt");

    final request = await http.put(
      Uri.parse("${Routes.recentWorks}/${entity.id}"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $jwt"
      },
      body: jsonEncode(createBody),
    );

    if (request.statusCode == 200) {
      final updated = {
        "id": jsonDecode(request.body)["id"]
      };

      await _updateAsset(anId: entity.id, aFile: image);

      return Result.success(DataJsonObject(status: 200, body: updated));
    }

    return Result.error(InfraException(cause: "Could not update recent work: ${request.body}"));
  }

  Future<void> _updateAsset({required String anId, required File aFile}) async {
    final updateAssetUri = Uri
        .parse("${Routes.uploadRecentWorkAsset}/$anId");

    final jwt = await SecureStorage().readSecureData("jwt");

    var fileBytes = await aFile.readAsBytes();

    var multipartFile = http.MultipartFile.fromBytes(
      'picture',
      fileBytes,
      filename: anId,
      contentType: MediaType('image', 'jpeg'),
    );

    var request = http.MultipartRequest('POST', updateAssetUri)
      ..files.add(multipartFile);

    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $jwt',
    });

    await request.send();
  }

  Future<Result<DataJsonObject, InfraException>> delete({required String id}) async {
    final jwt = await SecureStorage().readSecureData("jwt");

    final request = await http.delete(
        Uri.parse("${Routes.recentWorks}/$id"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $jwt"
        }
    );

    if (request.statusCode == 204) {
      final created = {
        "message": "recent work deleted"
      };

      return Result.success(DataJsonObject(status: 201, body: created));
    }

    return Result.error(InfraException(cause: "Could not delete recent work: ${request.body}"));
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