
import 'package:dekor_farben_app/screens/onboarding_screen/components/reducer/user_reducer.dart';
import 'package:redux/redux.dart';

import '../../../../blocs/user/user_state.dart';

class GlobalUserStore {

  static final Store<UserGetOneSuccessState> _store =
      Store<UserGetOneSuccessState>(userReducer,
          initialState: UserGetOneSuccessState.initial());

  static Store<UserGetOneSuccessState> get store => _store;
}