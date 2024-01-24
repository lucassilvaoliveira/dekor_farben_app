import 'dart:convert';

import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/global/routes/routes.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/reducer/global_user_store.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_result/multiple_result.dart';

import '../../../global/secure_storage.dart';

class CampaignHttpRepositoryImpl implements IBaseRepository<Campaign> {
  @override
  Future<Result<List<Campaign>, InfraException>> get() async {
    try {
      final uri = Uri.parse("https://decor-coins.onrender.com/api/companies");

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
  Future<Result<DataJsonObject, InfraException>> put({required Campaign entity}) async {
    final user = GlobalUserStore.store.state.user;
    final company = GlobalCompanyStore.store.state.company;

    final createBody = {
      "name": entity.campaignName,
      "description": entity.campaignDescription,
      "reward": entity.campaignReward.toString(),
      "initial_date": "${entity.campaignInitialDate.toIso8601String()}Z",
      "end_date": "${entity.campaignEndDate.toIso8601String()}Z",
      "company_id": company.id,
      "user_id": user.id,
      "is_open": true,
      "is_active": true
    };

    final jwt = await SecureStorage().readSecureData("jwt");

    final request = await http.post(
      Uri.parse(Routes.campaigns),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $jwt"
      },
      body: jsonEncode(createBody),
    );

    if (request.statusCode == 201) {
      final created = {
        "id": jsonDecode(request.body)["id"]["value"]
      };

      return Result.success(DataJsonObject(status: 201, body: created));
    }

    return Result.error(InfraException(cause: "Could not create campaign: ${request.body}"));
  }

  Future<Result<DataJsonObject, InfraException>> delete({required String id}) async {
    final jwt = await SecureStorage().readSecureData("jwt");

    final request = await http.delete(
      Uri.parse("${Routes.campaigns}/$id"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $jwt"
      }
    );

    if (request.statusCode == 204) {
      final created = {
        "message": "campaign deleted"
      };

      return Result.success(DataJsonObject(status: 201, body: created));
    }

    return Result.error(InfraException(cause: "Could not delete campaign: ${request.body}"));
  }

  Future<Result<DataJsonObject, InfraException>> update({required String id, required Campaign entity}) async {
    final createBody = {
      "name": entity.campaignName,
      "description": entity.campaignDescription,
      "reward": entity.campaignReward.toString(),
      "initial_date": "${entity.campaignInitialDate.toIso8601String()}Z",
      "end_date": "${entity.campaignEndDate.toIso8601String()}Z",
      "is_open": true,
      "is_active": true
    };

    final jwt = await SecureStorage().readSecureData("jwt");

    final request = await http.put(
      Uri.parse("${Routes.campaigns}/$id"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $jwt"
      },
      body: jsonEncode(createBody),
    );

    if (request.statusCode == 200) {
      final updated = {
        "id": jsonDecode(request.body)["id"]["value"]
      };

      return Result.success(DataJsonObject(status: 200, body: updated));
    }

    return Result.error(InfraException(cause: "Could not update campaign: ${request.body}"));
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

      if (response.statusCode == 200) {
        for (final campaign in campaigns) {
          for (final product in campaign.products) {
            final assetUri = Uri.parse("${Routes.getProductAsset}${product.id}");
            var assetResponse = await http.get(assetUri, headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization':
              'Bearer $jwt',
            });

            if (assetResponse.statusCode == 200) {
              product.image = assetResponse.bodyBytes;
            } else {
              product.image = null;
            }
          }
        }
      }

      return Success(campaigns);
    } catch (error) {
      return Error(InfraException(cause: error.toString()));
    }
  }
}