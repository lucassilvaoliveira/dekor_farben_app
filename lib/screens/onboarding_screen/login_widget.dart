import 'package:dekor_farben_app/blocs/user/user_bloc.dart';
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

    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(),
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
                      LoginFormWidget(pageController: _pageController, bottomSheetHeigh: bottomSheetHeigh),
                      SignUpBottomSheetForm(pageController: _pageController)
                    ],
                  ),
                ),
              ],
            ),
          ])),
    );
  }
}
