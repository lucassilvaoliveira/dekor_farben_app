import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/company_action.dart';

import '../../../../blocs/company/company_state.dart';

CompanyGetOneSuccessState companyReducer(CompanyGetOneSuccessState state, action) {
  if (action is SetCompanyAction) {
    return CompanyGetOneSuccessState(company: action.company);
  }

  return state;
}