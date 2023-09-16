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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
      margin: EdgeInsets.only(top: size.height * .02),
      height: size.height * .5,
      width: size.width,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: settingsOptionsData.length,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding, horizontal: kDefaultPadding),
          height: size.height * .08,
          width: size.width,
          child: Row(
            children: [
              Icon(settingsOptionsData[index]["iconProp"]),
              SizedBox(width: size.width * .1),
              SizedBox(
                width: size.width * .5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      settingsOptionsData[index]["nameProp"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      settingsOptionsData[index]["userName"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Icon(
                Icons.edit,
                color: kDefaultPrimaryGradient[0],
              )
            ],
          ),
        ),
      ),
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
