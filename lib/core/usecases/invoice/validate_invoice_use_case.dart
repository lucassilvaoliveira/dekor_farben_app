import 'package:multiple_result/multiple_result.dart';

import '../../../helpers/data_json_object.dart';
import '../../../helpers/infra_exception.dart';
import '../../../infrastructure/contracts/i_base_repository.dart';
import '../../../infrastructure/implementations/http/invoice_http_repository_impl.dart';

class ValidateInvoiceUseCase {
  final IBaseRepository repository;

  ValidateInvoiceUseCase({required this.repository});

  Future<Result<DataJsonObject, InfraException>> call({required String invoiceId}) async {
    if (repository is InvoiceHttpRepositoryImpl) {
      final repositoryImpl = repository as InvoiceHttpRepositoryImpl;
      return await repositoryImpl.validate(invoiceId: invoiceId);
    }

    throw InfraException(cause: "Could not validate invoice");
  }
}