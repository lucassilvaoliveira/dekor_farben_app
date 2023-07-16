import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/recently_works_widget.dart';
import 'package:flutter/material.dart';

class ScreenContent extends StatefulWidget {
  const ScreenContent({super.key});

  @override
  State<ScreenContent> createState() => _ScreenContentState();
}

class _ScreenContentState extends State<ScreenContent> {
  double containerRadiusWhenDrawerOpen = 0;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double iconSize = 20;
  bool drawerIsOpen = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (drawerIsOpen) {
          setState(() {
            containerRadiusWhenDrawerOpen = 0;
            xOffset = 0;
            yOffset = 0;
            scaleFactor = 1;
            drawerIsOpen = false;
          });
        }
      },
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: kDefaultScaffoldColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(containerRadiusWhenDrawerOpen),
                bottomLeft: Radius.circular(containerRadiusWhenDrawerOpen))),
        duration: const Duration(milliseconds: 300),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Olá, Lucas!',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 25),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      containerRadiusWhenDrawerOpen = 30;
                      xOffset = 230;
                      yOffset = 150;
                      scaleFactor = 0.6;
                      drawerIsOpen = true;
                    });
                  },
                  icon: Icon(
                    Icons.menu,
                    size: iconSize,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * .20,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Esta é a empresa Decor coins",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '500 Decor coins ',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const WidgetSpan(
                          child: Icon(Icons.star),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Trabalhos recentes",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 25),
            ),
            const SizedBox(height: 16),
            RecentlyWorksWidget(size: size)
          ],
        ),
      ),
    );
  }
}
