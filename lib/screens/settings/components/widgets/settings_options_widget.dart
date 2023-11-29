import 'package:dekor_farben_app/global/constants.dart';
import 'package:flutter/material.dart';

class SettingsOptionsWidget extends StatelessWidget {
  const SettingsOptionsWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: size.height * .02),
          height: size.height * .55,
          width: size.width,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 0),
            itemCount: settingsOptionsData.length,
            itemBuilder: (context, index) => SizedBox(
              width: size.width,
              child: TextBox(
                  iconProp: settingsOptionsData[index]["iconProp"],
                  text: settingsOptionsData[index]["userName"],
                  sectionName: settingsOptionsData[index]["nameProp"],
                  onPressed: () {
                    print('Hello World');
                  }
              ),
            ),
          ),
        ),
      ],
    );
  }
}

List<Map<String, dynamic>> settingsOptionsData = [
  {"iconProp": Icons.person, "nameProp": "Name", "userName": "Polo"},
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

class TextBox extends StatelessWidget {

  final IconData iconProp;
  final String text;
  final String sectionName;
  final void Function()? onPressed;

  const TextBox({
    super.key,
    required this.iconProp,
    required this.text,
    required this.sectionName,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0,
          blurRadius: 6,
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ], borderRadius: BorderRadius.circular(8), color: Colors.white),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: Row(
        children: [
          Icon(
            iconProp,
            size: 30,
            color: Colors.grey[700],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sectionName,
                  style: TextStyle(color: Colors.grey[500]),
                ),
                const SizedBox(height: 10),
                Text(text)
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}