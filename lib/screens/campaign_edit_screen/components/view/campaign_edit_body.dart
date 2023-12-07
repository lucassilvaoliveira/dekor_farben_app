import 'package:dekor_farben_app/screens/product_registration_screen/product_registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../global/constants.dart';
import '../../../../global/widgets/app_bar_widget.dart';
import '../../../../global/widgets/primary_select_option_button_widget.dart';
import '../../../../global/widgets/text_box_widget.dart';

class CampaignEditBody extends StatefulWidget {
  const CampaignEditBody({super.key});

  @override
  State<CampaignEditBody> createState() => _CampaignEditBodyState();
}

class _CampaignEditBodyState extends State<CampaignEditBody> {

  @override
  Widget build(BuildContext context) {
    Future<void> editField(String field) async {
      String newValue = "";
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text('Edite $field'),
            content: TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  hintText: "Informe o novo valor",
                  hintStyle: TextStyle(color: Colors.grey)
              ),
              onChanged: (value) {
                newValue = value;
              },
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.white),
                  )
              ),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(newValue),
                  child: const Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  )
              )
            ],
          )
      );
    }

    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 60),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarWidget(title: 'Campanha'),
            SizedBox(
                height: size.height * .65,
                width: size.width,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 0),
                  itemCount: settingsOptionsData.length,
                  itemBuilder: (context, index) =>
                      SizedBox(
                        width: size.width,
                        child: TextBoxWidget(
                            iconProp: settingsOptionsData[index]["icon"],
                            text: settingsOptionsData[index]["value"],
                            sectionName: settingsOptionsData[index]["fieldName"],
                            onPressed: () => editField(settingsOptionsData[index]["fieldName"])
                        ),
                      ),
                )
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: const PrimarySelectOptionButtonWidget(widgetColor: kDefaultPrimaryColor, text: 'Ver Produtos', isOpacity: false),
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => const ProductRegistrationScreen()),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const PrimarySelectOptionButtonWidget(widgetColor: Colors.red, text: 'Excluir', isOpacity: false)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


List<Map<String, dynamic>> settingsOptionsData = [
  {
    "icon": Icons.star,
    "fieldName": "Decor coins",
    "value": "1500"
  },
  {
    "icon": Icons.pending_actions,
    "fieldName": "Nome da campanha",
    "value": "Campanha setembro amarelo"
  },
  {
    "icon": Icons.calendar_month,
    "fieldName": "Data de início",
    "value": "25/02/2024"
  },
  {
    "icon": Icons.calendar_month,
    "fieldName": "Data final",
    "value": "15/03/2024"
  },
  {
    "icon": Icons.add,
    "fieldName": "Descrição",
    "value": "Na compra de R\$10,000 em borracha líquida, ganhe 1000 decor coins!"
  },
];

