import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/global/widgets/primary_select_option_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../../global/widgets/app_bar_widget.dart';

class InvoiceScreenBody extends StatefulWidget {
  const InvoiceScreenBody({super.key});

  @override
  State<InvoiceScreenBody> createState() => _InvoiceScreenBodyState();
}

class _InvoiceScreenBodyState extends State<InvoiceScreenBody> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppBarWidget(title: 'Notas Fiscais'),
              Container(
                height: size.height,
                width: size.width,
                margin: const EdgeInsets.only(top: 20),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 0),
                    itemCount: settingsOptionsData.length,
                    itemBuilder: (context, index) =>
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 15),
                                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 6,
                                        offset: const Offset(2, 6), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  width: size.width * .3,
                                  child: ClipOval(
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.asset(
                                        settingsOptionsData[index]["image"],
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.attach_file,
                                  color: Colors.grey[400],
                                  size: 45,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                            settingsOptionsData[index]["name"],
                                            textAlign: TextAlign.right,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: Text(
                                            settingsOptionsData[index]["document"],
                                            textAlign: TextAlign.right,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(color: Colors.black)
                                        ),
                                      ),
                                      PrimarySelectOptionButtonWidget(
                                        text: 'Validar',
                                        isOpacity: false,
                                        widgetColor: kDefaultPrimaryColor,
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20, bottom: 20),
                              height: 1,
                              color: Colors.black.withOpacity(.3),
                            ),
                          ],
                        )
                  )
              )
            ],
          ),
        )
    );
  }
}

List<Map<String, dynamic>> settingsOptionsData = [
  {
    "name": "Kaliel Eduard",
    "image": "assets/images/borracha_liquida.png",
    "document": "102.879.709-57"
  },
  {
    "name": "Márcio de Freitas",
    "image": "assets/images/quartzo_mica.png",
    "document": "154.698.778-01"
  },
  {
    "name": "Larissa de Freitas",
    "image": "assets/images/cimento_diamantado_aveludado.png",
    "document": "456.872.112-69"
  },
  {
    "name": "Larissa de Freitas",
    "image": "assets/images/cimento_diamantado_aveludado.png",
    "document": "456.872.112-69"
  },
  {
    "name": "Larissa de Freitas",
    "image": "assets/images/cimento_diamantado_aveludado.png",
    "document": "456.872.112-69"
  },
];

