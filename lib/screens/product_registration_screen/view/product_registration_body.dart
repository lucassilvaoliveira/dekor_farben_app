import 'package:dekor_farben_app/global/widgets/camera_widget.dart';
import 'package:flutter/material.dart';

import '../../../global/constants.dart';
import '../../../global/widgets/app_bar_widget.dart';

class ProductRegistrationBody extends StatefulWidget {
  const ProductRegistrationBody({super.key});

  @override
  State<ProductRegistrationBody> createState() =>
      _ProductRegistrationBodyState();
}

class _ProductRegistrationBodyState extends State<ProductRegistrationBody> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Novo Produto'),
        content: SizedBox(
          height: size.height * .2,
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(hintText: 'Nome'),
              ),
              const SizedBox(height: 20),
              CameraWidget(height: 40, width: 40)
            ],
          ),
        ),

        actions: [
          TextButton(onPressed: () {}, child: const Text('Salvar'))
        ],
      ),
    );

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: SingleChildScrollView(
          child: Column(children: [
            const AppBarWidget(title: 'Produtos da campanha'),
            Container(
              height: size.height * .68,
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: Text(
                                        settingsOptionsData[index]["name"],
                                        textAlign: TextAlign.right,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(color: Colors.black)
                                    ),
                                  ),
                                  const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                    size: 50,
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
                    ),
              )
            ),
            GestureDetector(
              child: ClipOval(
                child: Container(
                  width: 50,
                  height: 50,
                  color: kDefaultPrimaryColor,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              onTap: () => openDialog(),
            )
          ]),
        ));
  }
}

List<Map<String, dynamic>> settingsOptionsData = [
  {
    "name": "Borracha Líquida",
    "image": "assets/images/borracha_liquida.png",
  },
  {
    "name": "Quartzo Mica",
    "image": "assets/images/quartzo_mica.png",
  },
  {
    "name": "Cimento Diamantado Aveludado",
    "image": "assets/images/cimento_diamantado_aveludado.png",
  },
];
