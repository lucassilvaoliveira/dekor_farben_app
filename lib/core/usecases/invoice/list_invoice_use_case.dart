import 'package:dekor_farben_app/core/entities/invoice.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/invoice_http_repository_impl.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../helpers/infra_exception.dart';
import '../../../infrastructure/contracts/i_base_repository.dart';

class ListInvoiceByCompanyUseCase {
  final IBaseRepository<Invoice> repository;

  ListInvoiceByCompanyUseCase({required this.repository});

  Future<Result<List<Invoice>, InfraException>> call(String companyId) async {
    if (repository is InvoiceHttpRepositoryImpl) {
      final repositoryImpl = repository as InvoiceHttpRepositoryImpl;
      return await repositoryImpl.listByCompany(companyId: companyId);
    } else {
      return Future.error(InfraException(cause: "Could not complete operation"));
    }
  }
}