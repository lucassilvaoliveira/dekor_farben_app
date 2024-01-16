import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/global/widgets/primary_select_option_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../../global/widgets/app_bar_widget.dart';
import '../../../../global/widgets/text_box_widget.dart';

class CampaignRegistrationBody extends StatefulWidget {
  const CampaignRegistrationBody({super.key});

  @override
  State<CampaignRegistrationBody> createState() => _CampaignRegistrationBodyState();
}

class _CampaignRegistrationBodyState extends State<CampaignRegistrationBody> {
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
            const AppBarWidget(title: 'Cadastro da campanha'),
            SizedBox(
                height: size.height * .7,
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
            PrimarySelectOptionButtonWidget(
              widgetColor: kDefaultPrimaryColor,
              text: 'Salvar',
              isOpacity: false,
              onPressed: () {},
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
    "value": ""
  },
  {
    "icon": Icons.pending_actions,
    "fieldName": "Nome da campanha",
    "value": ""
  },
  {
    "icon": Icons.calendar_month,
    "fieldName": "Data de início",
    "value": ""
  },
  {
    "icon": Icons.calendar_month,
    "fieldName": "Data final",
    "value": ""
  },
  {
    "icon": Icons.add,
    "fieldName": "Descrição",
    "value": ""
  },
];
