import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductWidget extends StatelessWidget {
  final Size size;
  final Product product;

  const ProductWidget({
    super.key,
    required this.size,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.withOpacity(.3),
          child: ClipOval(
              child: product.image != null ? Image.memory(product.image!) : SvgPicture.asset("assets/images/no-data-img.svg")
          ),
        ),
        const SizedBox(width: 50),
        Flexible(
          child: Text(
            product.productName,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
