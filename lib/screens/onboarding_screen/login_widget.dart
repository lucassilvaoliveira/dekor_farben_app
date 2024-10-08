import 'package:dekor_farben_app/blocs/auth/auth_bloc.dart';
import 'package:dekor_farben_app/blocs/user/user_bloc.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/company_signup_bottom_sheet_form.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/signup_bottom_sheet_form.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/login_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<StatefulWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double progress =
        _pageController.hasClients ? (_pageController.page ?? 0) : 0;

    final bottomSheetHeigh = 400 + progress * 320;

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
            create: (context) => UserBloc()
        ),
        BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
        )
      ],
      child: SizedBox(
          height: bottomSheetHeigh,
          child: Stack(fit: StackFit.expand, children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: [
                      LoginFormWidget(pageController: _pageController, bottomSheetHeight: bottomSheetHeigh),
                      userType == 'user' ? SignUpBottomSheetForm(pageController: _pageController) : CompanySignupBottomSheetForm(pageController: _pageController)
                    ],
                  ),
                ),
              ],
            ),
          ])),
    );
  }
}
