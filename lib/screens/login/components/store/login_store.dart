import 'dart:ui';

import 'package:dekor_farben_app/screens/login/components/widgets/login_form_content.dart';
import 'package:flutter/material.dart';

class LoginStore extends ChangeNotifier {
  PageController loginPageController = PageController();

  void showLoginModal({required BuildContext context}) {
    Future.delayed(Duration.zero, () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white.withOpacity(.6),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(42), topRight: Radius.circular(42))),
        builder: (_) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: LoginFormContent(loginStore: this),
        ),
      );
    });
    notifyListeners();
  }

  void changeCurrentPage({required int page}) {
    if (loginPageController.page != null) {
      if (loginPageController.page! < 1) {
        loginPageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.linear);
      }
      loginPageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }
  }
}