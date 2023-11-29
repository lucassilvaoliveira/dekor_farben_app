import 'package:dekor_farben_app/screens/choose_company_screen/choose_company_screen.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../global/widgets/primary_button_widget.dart';

class SignUpBottomSheetForm extends StatelessWidget {
  final PageController pageController;

  const SignUpBottomSheetForm({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Container(
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: mediaQuery.viewInsets,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Crie sua conta',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 25),
              const TextFieldWidget(label: 'Nome', icon: Icons.person),
              const TextFieldWidget(label: 'Email', icon: Icons.email),
              const TextFieldWidget(label: 'CPF', icon: Icons.key),
              const TextFieldWidget(
                  label: 'Data de nascimento', icon: Icons.cake),
              const TextFieldWidget(label: 'Telefone', icon: Icons.email),
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
                      if (pageController.page == 1) {
                        pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.ease);
                      }
                    },
                    child: Text('Fazer Login',
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
                      child: const PrimaryButtonWidget(text: 'Criar'),
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
