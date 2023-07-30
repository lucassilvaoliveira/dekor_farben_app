import 'package:dekor_farben_app/global/texts.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/widgets/company_widget.dart';
import 'package:flutter/material.dart';

class ChooseCompanyBody extends StatelessWidget {
  const ChooseCompanyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: size.height * .3,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selecione a empresa\nque deseja ver hoje',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 30),
                ),
                Text(
                  chooseThemeScreenDescription,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 20),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height * .6,
            width: size.width,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: 10,
              itemBuilder: (_, index) => CompanyWidget(size: size),
            ),
          )
        ],
      ),
    );
  }
}


