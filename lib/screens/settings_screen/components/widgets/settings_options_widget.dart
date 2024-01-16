import 'package:dekor_farben_app/global/widgets/text_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../onboarding_screen/components/reducer/global_user_store.dart';

class SettingsOptionsWidget extends StatefulWidget {
  const SettingsOptionsWidget({super.key});

  @override
  State<SettingsOptionsWidget> createState() => _SettingsOptionsWidgetState();
}

class _SettingsOptionsWidgetState extends State<SettingsOptionsWidget> {
  final getUserData = _getUserAttributes();

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
            itemCount: getUserData.length,
            itemBuilder: (context, index) =>
                SizedBox(
                  width: size.width,
                  child: TextBoxWidget(
                      iconProp: getUserData[index]["iconProp"],
                      text: getUserData[index]["userName"].toString(),
                      sectionName: getUserData[index]["nameProp"],
                      onPressed: () => editField(getUserData[index]["nameProp"])
                  ),
                ),
          ),
        ),
      ],
    );
  }
}

List<Map<String, dynamic>> _getUserAttributes() {
  final userStore = GlobalUserStore.store;
  final anUser = userStore.state.user;

  final telephoneMask = MaskTextInputFormatter(
      mask: "(##) #####-####", type: MaskAutoCompletionType.lazy);

  final cpfMask = MaskTextInputFormatter(
      mask: "###.###.###-##", type: MaskAutoCompletionType.lazy);

  return [
    {
      "iconProp": Icons.person,
      "nameProp": "Nome",
      "userName": anUser.userName
    },
    {
      "iconProp": Icons.email,
      "nameProp": "Email",
      "userName": anUser.userEmail
    },
    {
      "iconProp": Icons.phone,
      "nameProp": "Telefone",
      "userName": telephoneMask.maskText(anUser.telephoneNumber)
    },
    {
      "iconProp": Icons.key,
      "nameProp": "CPF",
      "userName": cpfMask.maskText(anUser.userDocument)
    },
    {
      "iconProp": Icons.cake,
      "nameProp": "Data de nascimento",
      "userName": anUser.userBirthday.toString()
    },
  ];
}
