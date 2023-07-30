import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/screens/product_details_screen.dart/product_details_screen.dart';
import 'package:flutter/cupertino.dart';

class CampaignProductWidget extends StatelessWidget {
  final Size size;
  final Product product;
  const CampaignProductWidget(
      {super.key, required this.size, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: size.height,
            width: size.width * .5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.height * .1,
                  width: size.width,
                  child: Text(
                    product.productName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(product: product),
                      ),
                    );
                  },
                  child: Container(
                    height: size.height * .05,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: kDefaultContainerColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: const Center(
                      child: Text("Ver"),
                    ),
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
