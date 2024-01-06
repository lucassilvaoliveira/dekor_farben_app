
import 'package:dekor_farben_app/blocs/user/user_state.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/reducer/user_action.dart';

UserGetOneSuccessState userReducer(UserGetOneSuccessState state, action) {
  if (action is SetUserAction) {
    return UserGetOneSuccessState(user: action.user);
  }

  return state;
}