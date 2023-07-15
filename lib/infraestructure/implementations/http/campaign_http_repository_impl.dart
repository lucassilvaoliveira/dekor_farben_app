import 'dart:convert';

import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infraestructure/contracts/i_base_repository.dart';
import 'package:multiple_result/src/result.dart';
import 'package:http/http.dart' as http;

class CampaignHttpRepositoryImpl implements IBaseRepository<Campaign> {
  @override
  Future<Result<List<Campaign>, InfraException>> get() async {
    try {
      final uri = Uri.parse("http://localhost:8080/api/companies");

      final response = await http.get(uri);

      final List<dynamic> responseMap = jsonDecode(response.body);

      return Success(responseMap.map((e) => Campaign.fromApi(e)).toList());
    } catch (error) {
      print(error);
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
}