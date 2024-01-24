import 'dart:convert';
import 'dart:io';

import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/global/routes/routes.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../global/secure_storage.dart';

class ProductHttpRepositoryImpl implements IBaseRepository<Product> {
  @override
  Future<Result<List<Product>, InfraException>> get() async {
    try {
      final uri = Uri.parse("https://decor-coins.onrender.com/api/companies");

      final response = await http.get(uri);

      final List<dynamic> responseMap = jsonDecode(response.body);
      return Success(responseMap.map((e) => Product.fromMap(e)).toList());
    } catch (error) {
      return Error(InfraException(cause: error.toString()));
    }
  }

  @override
  Future<Result<Product, InfraException>> getOne({required String? entityId}) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  Future<Result<DataJsonObject, InfraException>> create({required Product entity, required File image}) async {
    final createBody = {
      "company_id": entity.companyId,
      "campaign_id": entity.campaignId,
      "name": entity.productName,
      "description": entity.productDescription,
      "price": entity.productPrice,
      "amount": 0,
      "is_active": true
    };

    final jwt = await SecureStorage().readSecureData("jwt");

    final request = await http.post(
      Uri.parse(Routes.products),
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

      await _updateAsset(anId: jsonDecode(request.body)["id"]["value"], aFile: image);
      
      return Result.success(DataJsonObject(status: 201, body: created));
    }

    return Result.error(InfraException(cause: "Could not create product: ${request.body}"));
  }

  Future<Result<DataJsonObject, InfraException>> update({required String id, required Product entity, required File image}) async {
    final createBody = {
      "company_id": entity.companyId,
      "campaign_id": entity.campaignId,
      "name": entity.productName,
      "description": entity.productDescription,
      "price": entity.productPrice,
      "amount": 0,
      "is_active": true
    };

    final jwt = await SecureStorage().readSecureData("jwt");

    final request = await http.put(
      Uri.parse("${Routes.products}/$id"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $jwt"
      },
      body: jsonEncode(createBody),
    );

    if (request.statusCode == 200) {
      final updated = {
        "id": jsonDecode(request.body)["product_id"]["value"]
      };

      await _updateAsset(anId: id, aFile: image);

      return Result.success(DataJsonObject(status: 200, body: updated));
    }

    return Result.error(InfraException(cause: "Could not update product: ${request.body}"));
  }

  Future<void> _updateAsset({required String anId, required File aFile}) async {
    final updateAssetUri = Uri
        .parse("${Routes.getProductAsset}$anId");

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

  @override
  Future<Result<DataJsonObject, InfraException>> put({required Product entity}) {
    // TODO: implement put
    throw UnimplementedError();
  }
}