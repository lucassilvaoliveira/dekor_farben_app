import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:flutter/material.dart';

class CampaignProductWidget extends StatelessWidget {
  final Size size;
  final Product product;
  const CampaignProductWidget(
      {super.key, required this.size, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          height: size.height * .2,
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: size.height,
                width: size.width * .3,
                child: Image.asset(
                  product.productImagePath != null
                      ? product.productImagePath!
                      : "assets/images/decorator-login-image.png",
                  width: 20,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                height: size.height,
                width: size.width * .5,
                child: Text(
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.black),
                  product.productName,
                  maxLines: 4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 2,
          width: size.width * 0.9,
          color: Colors.black.withOpacity(.3),
        )
      ],
    );
  }
}
