import 'dart:convert';
import 'dart:io';

import 'package:dekor_farben_app/core/entities/invoice.dart';
import 'package:dekor_farben_app/global/routes/routes.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../global/secure_storage.dart';

class InvoiceHttpRepositoryImpl implements IBaseRepository<Invoice> {

  static const headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  @override
  Future<Result<List<Invoice>, InfraException>> get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Result<Invoice, InfraException>> getOne({required String? entityId}) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  Future<Result<List<Invoice>, InfraException>> listByCompany({required String companyId}) async {
    try {
      final uri = Uri.parse("${Routes.invoiceByCompany}/$companyId");
      final jwt = await SecureStorage().readSecureData("jwt");

      var response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
        'Bearer $jwt',
      });

      final List<dynamic> json = jsonDecode(response.body);

      final List<Invoice> invoices = json.map((e) => Invoice.fromApi(e)).toList();

      for (var invoice in invoices) {
        final getImageResponse = await getAsset(anId: invoice.id);

        if (getImageResponse.isSuccess()) {
          invoice.image = getImageResponse.tryGetSuccess()?.body["image"];
        }
      }

      return Success(invoices);
    } catch (error) {
      return Error(InfraException(cause: error.toString()));
    }
  }

  Future<Result<DataJsonObject, InfraException>> validate({required String invoiceId}) async {
    try {
      final uri = Uri.parse("${Routes.validateInvoice}/$invoiceId");
      final jwt = await SecureStorage().readSecureData("jwt");

      var response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
        'Bearer $jwt',
      });

      if (response.statusCode == 200) {
        final body = {
          "message": "invoice validated"
        };
        return Success(DataJsonObject(status: 200, body: body));
      } else {
        return Error(InfraException(cause: response.body));
      }
    } catch (error) {
      return Error(InfraException(cause: error.toString()));
    }
  }

  Future<Result<DataJsonObject, InfraException>> getAsset({required String anId}) async {
    final getAssetUri = Uri
        .parse("${Routes.invoiceAsset}$anId");

    final jwt = await SecureStorage().readSecureData("jwt");

    var request = await http.get(getAssetUri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
      'Bearer $jwt',
    });

    if (request.statusCode == 200) {
      final response = {
        "image": request.bodyBytes
      };

      final DataJsonObject json =
      DataJsonObject(status: request.statusCode, body: response);

      return Success(json);
    } else {
      return Error(InfraException(cause: "Could not load image"));
    }
  }

  Future<Result<DataJsonObject, InfraException>> create({
    required Invoice entity,
    required File aFile
  }) async {
    try {
      final uri = _createUri(Routes.invoices);
      final jsonBody = _createJsonBody(entity);
      final jwt = await _readJwt();

      final response = await http.post(
        uri,
        headers: _addAuthorizationHeader(jwt),
        body: jsonEncode(jsonBody),
      );

      return _processResponse(response, entity, aFile, jwt);
    } catch (error) {
      return Error(InfraException(cause: error.toString()));
    }
  }

  Uri _createUri(String route) {
    return Uri.parse(route);
  }

  Map<String, dynamic> _createJsonBody(final Invoice entity) {
    return {
      "user_id": entity.userId,
      "company_id": entity.companyId,
      "campaign_id": entity.campaignId,
    };
  }

  Future<String> _readJwt() async {
    return await SecureStorage().readSecureData("jwt");
  }

  Map<String, String> _addAuthorizationHeader(String jwt) {
    return {
      ...headers,
      "Authorization": "Bearer $jwt",
    };
  }

  Future<Result<DataJsonObject, InfraException>> _processResponse(
      final http.Response response,
      final Invoice entity,
      final File aFile,
      final String jwt) async {
    if (response.statusCode == 201) {
      final invoiceId = jsonDecode(response.body)["invoice_id"]["value"];
      entity.id = invoiceId;
      final uploadImageRequest = await uploadAsset(entity, aFile, jwt);

      if (uploadImageRequest.isSuccess()) {
        return Success(
            DataJsonObject(
                status: response.statusCode,
                body: {"message": response.body}
            )
        );
      }
    }

    return Error(InfraException(cause: "Could not create invoice"));
  }


  Future<Result<DataJsonObject, InfraException>> uploadAsset(
      final Invoice entity,
      final File aFile, final String jwt) async {
    final assetUri = Uri
        .parse("${Routes.invoiceAsset}${entity.id}");

    var fileBytes = await aFile.readAsBytes();

    var multipartFile = http.MultipartFile.fromBytes(
      'picture',
      fileBytes,
      filename: entity.id,
      contentType: MediaType('image', 'jpeg'),
    );

    var request = http.MultipartRequest('POST', assetUri)
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

  @override
  Future<Result<DataJsonObject, InfraException>> put({required Invoice entity}) {
    // TODO: implement put
    throw UnimplementedError();
  }
}