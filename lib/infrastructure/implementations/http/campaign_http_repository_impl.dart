import 'dart:convert';

import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/global/routes/routes.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_result/multiple_result.dart';

import '../../../global/secure_storage.dart';

class CampaignHttpRepositoryImpl implements IBaseRepository<Campaign> {
  @override
  Future<Result<List<Campaign>, InfraException>> get() async {
    try {
      final uri = Uri.parse("http://localhost:8080/api/companies");

      final response = await http.get(uri);

      final List<dynamic> responseMap = jsonDecode(response.body);

      return Success(responseMap.map((e) => Campaign.fromApi(e)).toList());
    } catch (error) {
      return Error(InfraException(cause: error.toString()));
    }
  }

  @override
  Future<Result<Campaign, InfraException>> getOne({required String? entityId}) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<Result<DataJsonObject, InfraException>> put({required Campaign entity}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  Future<Result<List<Campaign>, InfraException>> getAllByCompanyId({required String companyId}) async {
    try {
      final uri = Uri.parse("${Routes.getCampaignsByCompanyId}/$companyId");
      final jwt = await SecureStorage().readSecureData("jwt");

      var response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
        'Bearer $jwt',
      });


      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> jsonCompanies = json['items'];

      final List<Campaign> campaigns =
      jsonCompanies.map((e) => Campaign.fromApi(e)).toList();

      return Success(campaigns);
    } catch (error) {
      return Error(InfraException(cause: error.toString()));
    }
  }
}