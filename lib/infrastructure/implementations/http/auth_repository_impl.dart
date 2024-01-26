import 'dart:convert';

import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_login_repository.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:multiple_result/multiple_result.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/entities/company.dart';
import '../../../core/entities/user.dart';
import '../../../global/constants.dart';
import '../../../global/routes/routes.dart';
import '../../../global/secure_storage.dart';
import '../../../screens/choose_company_screen/components/reducer/company_action.dart';
import '../../../screens/onboarding_screen/components/reducer/global_user_store.dart';
import '../../../screens/onboarding_screen/components/reducer/user_action.dart';

class AuthRepositoryImpl extends ILoginRepository {

  @override
  Future<Result<DataJsonObject, InfraException>> call({
    required String email,
    required String password
  }) async {
    try {
      final response = await http.post(
        Uri.parse(Routes.authenticate),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password
        }),
      );

      if (response.statusCode == 200) {
        return await _onSuccessAuth(response, email);
      }

      return Error(InfraException(
          cause: "Could not authenticate: ${response.body}"
      ));
    } on Exception catch(e) {
      return Error(InfraException(cause: e.toString()));
    }
  }

  Future<Success<DataJsonObject, InfraException>> _onSuccessAuth(
      final http.Response response,
      final String email) async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime
        .now()
        .millisecondsSinceEpoch;
    final expirationTime =
        currentTime + const Duration(days: 5).inMilliseconds;

    final token = jsonDecode(response.body)["token"];

    SecureStorage()
        .writeSourceData("jwt", token);

    prefs.setInt("jwtExpiration", expirationTime);

    await _storeCurrentUser(token, email);

    final success = {
      "jwt": token
    };

    return Success(DataJsonObject(
        status: response.statusCode,
        body: success
    ));
  }

  Future<void> _storeCurrentUser(
      final String token,
      final String email
      ) async {
    final getUserUri = Uri.parse(Routes.users);

    final queryParams = {"sort": "email", "search": email};

    final getUserUriWithParams =
    getUserUri.replace(queryParameters: queryParams);

    final userResponse = await http.get(getUserUriWithParams, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
      'Bearer $token',
    });

    final Map<String, dynamic> userResponseApi = jsonDecode(userResponse.body);
    final List<dynamic> userJson = userResponseApi['items'];
    final User user = User.fromRestRoute(userJson[0]);
    final globalUserStore = GlobalUserStore.store;
    globalUserStore.dispatch(SetUserAction(user: user));

    if (userType == 'company') {
      await _storeCurrentCompany(email, token);
    }
  }

  Future<void> _storeCurrentCompany(
      final String email,
      final String token
      ) async {
    final getCompanyUri = Uri.parse(Routes.companies);

    final queryParams = {"sort": "email", "search": email};

    final getCompanyUriWithParams =
    getCompanyUri.replace(queryParameters: queryParams);

    final request = await http.get(getCompanyUriWithParams, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
      'Bearer $token',
    });

    final Map<String, dynamic> response = jsonDecode(request.body);
    final Company company = Company.fromApi(response["items"][0]);
    final globalCompanyStore = GlobalCompanyStore.store;
    globalCompanyStore.dispatch(SetCompanyAction(company: company));
  }
}