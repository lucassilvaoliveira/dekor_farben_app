import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:dekor_farben_app/core/usecases/company/get_company_use_case.dart';
import 'package:dekor_farben_app/infrastructure/implementations/memory/company_memory_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should be return a list of company's", () async {
    final GetCompanyUseCase getCompanyUseCase = GetCompanyUseCase(repository: CompanyMemoryRepositoryImpl());
    var sut;

    final call = await getCompanyUseCase.call();

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut is List<Company>, true);
  });
}
