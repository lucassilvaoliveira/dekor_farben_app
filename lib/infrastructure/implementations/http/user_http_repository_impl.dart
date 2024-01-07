import 'dart:convert';

import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/company_action.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global/routes/routes.dart';
import '../../../global/secure_storage.dart';

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
  Future<Result<DataJsonObject, InfraException>> put(
      {required User entity}) async {
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
        "cpf": entity.userDocument.toString(),
        "birthday": entity.userBirthday?.toIso8601String() ?? "",
        "is_active": "true",
        "telephone_number": entity.telephoneNumber
      }),
    );

    final json = DataJsonObject(
        status: response.statusCode, body: jsonDecode(response.body));

    if (response.statusCode == 201) {
      final String jwt = await getJwt(entity.userEmail, entity.userPassword);

      if (userType == "company") {
        final companyData = {
          "name": entity.userName,
          "email": entity.userEmail,
          "password": entity.userPassword,
        };

        final createdCompanyRequest = await http.post(
          Uri.parse(Routes.companies),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode(companyData),
        );

        if (createdCompanyRequest.statusCode == 201) {
          final createdCompanyResponse = jsonDecode(createdCompanyRequest.body);
          final String aCompanyId = createdCompanyResponse["an_id"]["value"];

          final getCompanyRequest = await http.get(
            Uri.parse("${Routes.companies}/$aCompanyId"),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              'Authorization': 'Bearer $jwt',
            },
          );

          if (getCompanyRequest.statusCode == 200) {
            final globalStoreCompany = GlobalCompanyStore.store;
            final companyJson = jsonDecode(getCompanyRequest.body);
            final Company company = Company.fromApi(companyJson);
            globalStoreCompany.dispatch(SetCompanyAction(company: company));
          }
        }
      }

      return Result.success(json);
    } else {
      return Result.error(
          InfraException(cause: "An error occurred ${json.body}"));
    }
  }
}

Future<String> getJwt(final String email, final String password) async {
  final response = await http.post(
    Uri.parse(Routes.authenticate),
    headers: {"Content-Type": "application/json", "Accept": "application/json"},
    body: jsonEncode(<String, String>{"email": email, "password": password}),
  );

  if (response.statusCode == 200) {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final expirationTime = currentTime + const Duration(days: 5).inMilliseconds;

    final token = jsonDecode(response.body)["token"];

    SecureStorage().writeSourceData("jwt", token);

    prefs.setInt("jwtExpiration", expirationTime);

    return token;
  }

  return "";
}
