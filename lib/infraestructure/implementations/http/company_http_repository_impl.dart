import 'dart:convert';

import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infraestructure/contracts/i_base_repository.dart';
import 'package:multiple_result/src/result.dart';
import 'package:http/http.dart' as http;

class CompanyHttpRepositoryImpl implements IBaseRepository<Company> {
  @override
  Future<Result<List<Company>, InfraException>> get() async {
    try {
      final uri = Uri.parse("http://localhost:8080/api/companies");

      final response = await http.get(uri);

      final List<dynamic> responseMap = jsonDecode(response.body);

      return Success(responseMap.map((e) => Company.fromApi(e)).toList());
    } catch (error) {
      print(error);
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