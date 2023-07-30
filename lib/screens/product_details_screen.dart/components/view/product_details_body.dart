import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:flutter/material.dart';

class ProductDetailsBody extends StatelessWidget {
  final Product product;
  const ProductDetailsBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            height: size.height * .40,
            width: size.width,
            child: Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: kDefaultContainerColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: Image.asset(product.productImagePath != null
                  ? product.productImagePath!
                  : "assets/images/decorator-login-image.png"),
            ),
          ),
          SizedBox(height: size.height * .02),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            height: size.height * .5,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: size.height * .05),
                SizedBox(
                  height: size.height * .25,
                  width: size.width,
                  child: Text(
                    product.productDescription,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 8,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: size.height * .05),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Valor unidade: R\$",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.black),
                      ),
                      TextSpan(
                        text: product.productPrice.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
