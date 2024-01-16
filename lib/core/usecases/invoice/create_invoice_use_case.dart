import 'dart:io';

import 'package:dekor_farben_app/core/entities/invoice.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/invoice_http_repository_impl.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../helpers/data_json_object.dart';
import '../../../helpers/infra_exception.dart';
import '../../../infrastructure/contracts/i_base_repository.dart';

class CreateInvoiceUseCase {
  final IBaseRepository repository;

  CreateInvoiceUseCase({required this.repository});

  Future<Result<DataJsonObject, InfraException>> call({
    required Invoice invoice,
    required File aFile
  }) async {
    if (repository is InvoiceHttpRepositoryImpl) {
      final repositoryImpl = repository as InvoiceHttpRepositoryImpl;
      return await repositoryImpl.create(entity: invoice, aFile: aFile);
    }

    throw InfraException(cause: "Could not create invoice");
  }
}
