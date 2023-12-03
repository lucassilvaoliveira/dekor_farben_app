import 'package:dekor_farben_app/global/widgets/text_box_widget.dart';
import 'package:flutter/material.dart';

class SettingsOptionsWidget extends StatefulWidget {
  const SettingsOptionsWidget({super.key});

  @override
  State<SettingsOptionsWidget> createState() => _SettingsOptionsWidgetState();
}

class _SettingsOptionsWidgetState extends State<SettingsOptionsWidget> {

  //Edit field
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
            decoration: InputDecoration(
              hintText: "Informe o novo $field",
              hintStyle: const TextStyle(color: Colors.grey)
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: size.height * .02),
          height: size.height * .55,
          width: size.width,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 0),
            itemCount: settingsOptionsData.length,
            itemBuilder: (context, index) =>
                SizedBox(
                  width: size.width,
                  child: TextBoxWidget(
                      iconProp: settingsOptionsData[index]["iconProp"],
                      text: settingsOptionsData[index]["userName"],
                      sectionName: settingsOptionsData[index]["nameProp"],
                      onPressed: () => editField(settingsOptionsData[index]["nameProp"])
                  ),
                ),
          ),
        ),
      ],
    );
  }
}

List<Map<String, dynamic>> settingsOptionsData = [
  {"iconProp": Icons.person, "nameProp": "Name", "userName": "Polooooooooooooooooooooooooooooooooooooooooooooooooooooooooo"},
  {
    "iconProp": Icons.email,
    "nameProp": "Email",
    "userName": "solvel.lucas@gmail.com"
  },
  {
    "iconProp": Icons.phone,
    "nameProp": "Telefone",
    "userName": "(47) 98913-1785"
  },
  {"iconProp": Icons.key, "nameProp": "CPF", "userName": "136.658.799.57"},
  {
    "iconProp": Icons.card_giftcard,
    "nameProp": "Data de nascimento",
    "userName": "24/09/2003"
  },
];
