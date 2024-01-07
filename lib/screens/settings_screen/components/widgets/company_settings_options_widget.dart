import 'package:dekor_farben_app/global/widgets/text_box_widget.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/reducer/global_user_store.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CompanySettingsOptionsWidget extends StatefulWidget {
  const CompanySettingsOptionsWidget({super.key});

  @override
  State<CompanySettingsOptionsWidget> createState() =>
      _CompanySettingsOptionsWidgetState();
}

class _CompanySettingsOptionsWidgetState
    extends State<CompanySettingsOptionsWidget> {
  //Edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text('Editar $field'),
              content: TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Informe o novo $field",
                    hintStyle: const TextStyle(color: Colors.grey)),
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
                    )),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(newValue),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final getCompanyData = _getCompanyAttributes();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: size.height * .02),
          height: size.height * .55,
          width: size.width,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 0),
            itemCount: getCompanyData.length,
            itemBuilder: (context, index) => SizedBox(
              width: size.width,
              child: TextBoxWidget(
                iconProp: getCompanyData[index]["iconProp"],
                text: getCompanyData[index]["userName"],
                sectionName: getCompanyData[index]["nameProp"],
                onPressed: () => editField(getCompanyData[index]["nameProp"]),
                isEditable: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

List<Map<String, dynamic>> _getCompanyAttributes() {
  final companyStore = GlobalCompanyStore.store;
  final userStore = GlobalUserStore.store;

  final aCompany = companyStore.state.company;
  final anUser = userStore.state.user;

  final telephoneMask = MaskTextInputFormatter(
      mask: "(##) #####-####", type: MaskAutoCompletionType.lazy);

  final cnpjMask = MaskTextInputFormatter(
      mask: "##.###.###/####-##", type: MaskAutoCompletionType.lazy);

  return [
    {
      "iconProp": Icons.person,
      "nameProp": "Nome",
      "userName": aCompany.companyName
    },
    {
      "iconProp": Icons.email,
      "nameProp": "Email",
      "userName": aCompany.companyEmail
    },
    {
      "iconProp": Icons.phone,
      "nameProp": "Telefone",
      "userName": telephoneMask.maskText(anUser.telephoneNumber)
    },
    {
      "iconProp": Icons.key,
      "nameProp": "CNPJ",
      "userName": cnpjMask.maskText(anUser.userDocument)
    },
  ];
}
