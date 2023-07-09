import 'package:dekor_farben_app/screens/login/components/atom/login_atoms.dart';
import 'package:rx_notifier/rx_notifier.dart';

class LoginReducer extends RxReducer {
  LoginReducer() {
    on(() => [userIsCompany.value], setCompanyLoginType.call);

    on(() => [userIsCustomer.value], setCustomerLoginType.call);
  }

  void setCustomerLoginType() {
    loginTypeState.setValue("customer");
  }

  void setCompanyLoginType() {
    loginTypeState.setValue("company");
  }

}