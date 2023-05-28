import 'package:dekor_farben_app/screens/login/components/store/login_store.dart';
import 'package:dekor_farben_app/screens/login/components/view/login_body.dart';
import 'package:flutter/material.dart';

class LoginPresenter extends StatefulWidget {
  const LoginPresenter({Key? key}) : super(key: key);

  @override
  State<LoginPresenter> createState() => _LoginPresenterState();
}

class _LoginPresenterState extends State<LoginPresenter> {

  late LoginStore loginStore;

  @override
  void initState() {
    super.initState();
    loginStore = LoginStore();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: loginStore, builder: (context, child) => LoginView(loginStore: loginStore));
  }
}
