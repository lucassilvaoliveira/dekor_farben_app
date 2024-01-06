import 'package:dekor_farben_app/blocs/user/user_state.dart';
import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:dekor_farben_app/screens/home_screen/components/view/home_screen_body.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/reducer/global_user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomeScreen extends StatelessWidget {
  final Company company;

  const HomeScreen({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StoreProvider<UserGetOneSuccessState>(
          store: GlobalUserStore.store,
          child: HomeScreenBody(company: company),
        ),
      ),
    );
  }
}
