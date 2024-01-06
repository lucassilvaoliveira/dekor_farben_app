import 'dart:convert';

import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:dekor_farben_app/global/routes/routes.dart';
import 'package:dekor_farben_app/global/secure_storage.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:http/http.dart' as http;
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
        final getAssetUri = Uri
            .parse("${Routes.getCompanyAsset}${company.id}");

        var aCompanyAssetResponse = await http.get(getAssetUri, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
          'Bearer $jwt',
        });

        company.image = aCompanyAssetResponse.bodyBytes;
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
}