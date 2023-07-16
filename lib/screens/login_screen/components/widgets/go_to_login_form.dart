import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/screens/login_screen/components/atom/login_atoms.dart';
import 'package:dekor_farben_app/screens/login_screen/components/widgets/login_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';


class GoToLoginForm extends StatelessWidget {
  final Size size;
  final String buttonText;
  const GoToLoginForm({Key? key, required this.size, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (buttonText == "Empresa") {
          userIsCompany.call();
        } else if (buttonText == "Usuário") {
          userIsCustomer.call();
        }
        Navigator.push(context, CupertinoPageRoute(
            builder: (context) => LoginForm(loginType: context.select(() => loginTypeState.value))));
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
