import 'dart:convert';

import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:dekor_farben_app/global/routes/routes.dart';
import 'package:dekor_farben_app/global/secure_storage.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_result/multiple_result.dart';

class CompanyHttpRepositoryImpl implements IBaseRepository<Company> {
  @override
  Future<Result<List<Company>, InfraException>> get() async {
    try {
      final uri = Uri.parse(Routes.companies);
      final jwt = await SecureStorage().readSecureData("jwt");

      var response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
        'Bearer $jwt',
      });


      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> jsonCompanies = json['items'];

      final List<Company> companies =
      jsonCompanies.map((e) => Company.fromApi(e)).toList();

      for (var company in companies) {
        final getImageResponse = await getAsset(anId: company.id);

        if (getImageResponse.isSuccess()) {
          company.image = getImageResponse.tryGetSuccess()?.body["image"];
        }
      }

      return Success(companies);
    } catch (error) {
      return Error(InfraException(cause: error.toString()));
    }
  }

  @override
  Future<Result<Company, InfraException>> getOne({required String? entityId}) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<Result<DataJsonObject, InfraException>> put({required Company entity}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  Future<Result<DataJsonObject, InfraException>> getAsset({required String anId}) async {
    final getAssetUri = Uri
        .parse("${Routes.getCompanyAsset}$anId");

    final jwt = await SecureStorage().readSecureData("jwt");

    var aCompanyAssetResponse = await http.get(getAssetUri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
      'Bearer $jwt',
    });

    if (aCompanyAssetResponse.statusCode == 200) {
      final response = {
        "image": aCompanyAssetResponse.bodyBytes
      };

      final DataJsonObject json =
      DataJsonObject(status: aCompanyAssetResponse.statusCode, body: response);

      return Success(json);
    } else {
      return Error(InfraException(cause: "Could not load image"));
    }
  }

  Future<Result<DataJsonObject, InfraException>> updateAsset({required String anId, required XFile aFile}) async {
    final updateAssetUri = Uri
        .parse("${Routes.getCompanyAsset}$anId");

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

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseJson = {
        "response": "image loaded successfully"
      };

      final DataJsonObject json =
      DataJsonObject(status: response.statusCode, body: responseJson);

      return Success(json);
    } else {
      return Error(InfraException(cause: "Could not load image"));
    }
  }

}