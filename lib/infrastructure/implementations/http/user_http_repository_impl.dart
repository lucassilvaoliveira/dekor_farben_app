import 'dart:convert';

import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:http/http.dart' as http;

import '../../../global/routes/routes.dart';

class UserHttpRepositoryImpl extends IBaseRepository<User> {

  @override
  Future<Result<List<User>, InfraException>> get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Result<User, InfraException>> getOne({required String? entityId}) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<Result<DataJsonObject, InfraException>> put({required User entity}) async {
    final response = await http.post(
      Uri.parse(Routes.users),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(<String, String>{
        "name": entity.userName,
        "email": entity.userEmail,
        "password": entity.userPassword,
        "cpf": entity.userCpf.toString(),
        "birthday": entity.userBirthday.toIso8601String(),
        "is_active": "true",
        "telephone_number": entity.telephoneNumber
      }),
    );

    final json = DataJsonObject(status: response.statusCode, body: jsonDecode(response.body));

    if (response.statusCode == 201) {
      return Result.success(json);
    } else {
      return Result.error(InfraException(cause: "An error occurred"));
    }
  }
}