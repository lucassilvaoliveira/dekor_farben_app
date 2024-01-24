import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/screens/product_edit_screen/product_edit_screen.dart';
import 'package:dekor_farben_app/screens/product_registration_screen/product_registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../global/constants.dart';
import '../../../global/widgets/app_bar_widget.dart';

class ProductDetailBody extends StatefulWidget {
  final Campaign campaign;

  const ProductDetailBody({super.key, required this.campaign});

  @override
  State<ProductDetailBody> createState() =>
      _ProductDetailBodyState();
}

class _ProductDetailBodyState extends State<ProductDetailBody> {
  @override
  Widget build(BuildContext context) {
    final products = widget.campaign.products;
    final size = MediaQuery.of(context).size;

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: SingleChildScrollView(
          child: Column(children: [
            const AppBarWidget(title: 'Produtos da campanha'),
            Container(
              height: size.height * .68,
              width: size.width,
              margin: const EdgeInsets.only(top: 20),
              child: products.isNotEmpty ? ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 0),
                itemCount: products.length,
                itemBuilder: (context, index) =>
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductEditScreen(product: products[index]))),
                          child: Row(
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
                                    child: products[index].image != null ? Image.memory(
                                      products[index].image!,
                                      width: 20,
                                    ) : SvgPicture.asset("assets/images/no-data-img.svg", width: 20),
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
                                          products[index].productName,
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
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 20),
                          height: 1,
                          color: Colors.black.withOpacity(.3),
                        ),
                      ],
                    ),
              ) : SvgPicture.asset("assets/images/no-data-img.svg")
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
              onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductRegistrationScreen(campaign: widget.campaign))),
            )
          ]),
        ));
  }
}
