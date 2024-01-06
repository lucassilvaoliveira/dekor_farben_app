import 'package:dekor_farben_app/blocs/company/company_state.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/company_reducer.dart';
import 'package:redux/redux.dart';

class GlobalCompanyStore {
  static final Store<CompanyGetOneSuccessState> _store =
      Store<CompanyGetOneSuccessState>(companyReducer,
          initialState: CompanyGetOneSuccessState.initial());

  static Store<CompanyGetOneSuccessState> get store => _store;
}
