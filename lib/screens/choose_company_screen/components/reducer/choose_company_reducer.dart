import 'package:dekor_farben_app/core/usecases/company/get_company_use_case.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/company_http_repository_impl.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/atom/choose_company_atoms.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ChooseCompanyReducer extends RxReducer {

  final GetCompanyUseCase useCase = GetCompanyUseCase(repository: CompanyHttpRepositoryImpl());

  ChooseCompanyReducer() {
    on(() => [companyListState.value], setPopulateCompanyList.call);
  }

  void setPopulateCompanyList() async {
    final call = await useCase.call();

    call.when((success) => companyListState.setValue(success), (error) => exceptionOnCompanyListState.setValue(error));
  }
}