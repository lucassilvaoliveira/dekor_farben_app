import 'package:dekor_farben_app/screens/choose_company_screen/choose_company_screen.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../global/widgets/primary_button_widget.dart';

class LoginFormWidget extends StatelessWidget {
  final PageController pageController;
  final double bottomSheetHeigh;

  const LoginFormWidget({Key? key, required this.pageController, required this.bottomSheetHeigh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Container(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Realize seu Login',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 25),
              const TextFieldWidget(label: 'Email', icon: Icons.email),
              const TextFieldWidget(
                label: 'Senha',
                icon: Icons.lock,
                hidden: true,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (pageController.page == 0) {
                        pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.ease);
                      }
                    },
                    child: Text('Criar Conta',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 20)),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const ChooseCompanyScreen(),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: size.width * 0.4,
                      child: const PrimaryButtonWidget(text: 'Entrar'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
