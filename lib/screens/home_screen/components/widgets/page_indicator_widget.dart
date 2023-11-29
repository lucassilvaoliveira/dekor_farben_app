import 'package:dekor_farben_app/global/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicatorWidget extends StatelessWidget {
  final PageController controller;
  final int count;

  const PageIndicatorWidget({super.key, required this.controller, required this.count});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: 1,
          width: size.width * .8,
          color: Colors.black.withOpacity(.3),
        ),
        Container(
          margin: EdgeInsets.only(top: size.height * .02),
          alignment: Alignment.center,
          child: Text(
            "Arraste para o lado",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: size.height * .02),
          alignment: Alignment.center,
          child: SmoothPageIndicator(
            controller: controller,
            count: count,
            effect: const ExpandingDotsEffect(
                activeDotColor: kDefaultPrimaryColor,
                dotColor: kDefaultContainerColor),
          ),
        ),
      ],
    );
  }
}
