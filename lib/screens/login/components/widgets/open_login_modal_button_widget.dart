import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/screens/login/components/store/login_store.dart';
import 'package:flutter/material.dart';

class OpenLoginModalButtonWidget extends StatelessWidget {
  final Size size;
  final String buttonText;
  final LoginStore loginStore;
  const OpenLoginModalButtonWidget({Key? key, required this.size, required this.buttonText, required this.loginStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        loginStore.showLoginModal(context: context);
      },
      child: Container(
        height: size.height * .08,
        width: size.width * .25,
        decoration: BoxDecoration(
          color: kDefaultContainerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
