import 'package:dekor_farben_app/global/widgets/app_bar_widget.dart';
import 'package:dekor_farben_app/global/widgets/primary_select_option_button_widget.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../global/constants.dart';

class CampaignRegistrationBody extends StatelessWidget {
  const CampaignRegistrationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 60),
        width: size.width,
        child: const SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(title: 'Cadastro da Campanha'),
              SizedBox(height: 20),
              TextFieldWidget(label: 'Decor Coins', icon: Icons.edit),
              TextFieldWidget(label: 'Nome da campanha', icon: Icons.edit),
              TextFieldWidget(label: 'Data de início', icon: Icons.edit),
              TextFieldWidget(label: 'Data final', icon: Icons.edit),
              TextFieldWidget(label: 'Descrição', icon: Icons.edit),
              SizedBox(height: 40),
              PrimarySelectOptionButtonWidget(widgetColor: kDefaultPrimaryColor, text: 'Ver Produtos', isOpacity: false),
              SizedBox(height: 20),
              PrimarySelectOptionButtonWidget(widgetColor: Colors.red, text: 'Excluir', isOpacity: false)
            ],
          ),
        ),
      ),
    );
  }
}
