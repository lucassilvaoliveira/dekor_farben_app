import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:dekor_farben_app/core/usecases/company/get_company_use_case.dart';
import 'package:dekor_farben_app/core/usecases/company/get_one_company_use_case.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/infraestructure/implementations/memory/company_memory_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should be return a list of company's", () async {
    final GetCompanyUseCase getCompanyUseCase = GetCompanyUseCase(repository: CompanyMemoryRepositoryImpl());
    var sut;

    final call = await getCompanyUseCase.call();

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut is List<Company>, true);
  });

  test("should be return an specific company", () async {
    final GetOneCompanyUseCase getOneCompanyUseCase = GetOneCompanyUseCase(repository: CompanyMemoryRepositoryImpl());
    var sut;

    final Company companyToFind = Company(
      id: uuid.v4(),
      companyName: "luxas company",
      companyImagePath: null,
      companyPassword: uuid.v4(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final call = await getOneCompanyUseCase.call(companyId: companyToFind.id);

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut.id, companyToFind.id);
  });
}
