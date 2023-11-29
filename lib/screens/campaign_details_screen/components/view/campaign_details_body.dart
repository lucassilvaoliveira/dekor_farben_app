import 'dart:io';

import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/global/widgets/primary_select_option_button_widget.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/page_indicator_widget.dart';
import 'package:dekor_farben_app/screens/product_details_screen.dart/components/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../global/widgets/app_bar_widget.dart';

class CampaignDetailsBody extends StatefulWidget {
  final Campaign campaign;

  const CampaignDetailsBody({super.key, required this.campaign});

  @override
  State<StatefulWidget> createState() => _CampaignDetailsBodySate();
}

class _CampaignDetailsBodySate extends State<CampaignDetailsBody> {
  final _controller = PageController();

  File? _image;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Campaign aCampaign = widget.campaign;
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 60),
            height: size.height * .22,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWidget(title: 'Campanha ${aCampaign.campaignName}'),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      aCampaign.campaignDescription,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 20),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
            width: size.width,
            child: Text(
              'Produtos da campanha',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20),
            height: 140,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(2, 6), // changes position of shadow
                ),
              ],
            ),
            child: PageView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemBuilder: (_, index) => ProductWidget(
                size: size,
                product: products[index],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          PageIndicatorWidget(
              controller: _controller, count: products.length),
          Flexible(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 370,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'Já realizou a compra? Anexe a nota fiscal para receber a sua recompensa',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PrimarySelectOptionButtonWidget(widgetColor: kDefaultPrimaryColor, text: 'Enviar nota fiscal', isOpacity: _image == null),
                      GestureDetector(
                        onTap: () async {
                          var source = ImageSource.gallery;
                          XFile? image = await _imagePicker.pickImage(
                              source: source,
                              imageQuality: 50
                          );

                          setState(() {
                            _image = File(image!.path);
                          });
                        },
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          size: 50,
                          color: kDefaultPrimaryColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

List<Product> products = [
  Product(
      id: '1',
      companyId: '1',
      productPrice: 1000,
      productName: 'Borracha Líquida',
      productDescription: 'Empermeabilizante',
      productImagePath: '',
      productAmount: 2,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now()),
  Product(
      id: '1',
      companyId: '1',
      productPrice: 1000,
      productName: 'Diamante Aveludado',
      productDescription: 'Empermeabilizante',
      productImagePath: '',
      productAmount: 2,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now())
];
