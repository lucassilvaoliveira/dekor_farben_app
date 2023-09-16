import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/recently_works_widget.dart';
import 'package:flutter/material.dart';

class AdminScreenContent extends StatefulWidget {
  const AdminScreenContent({super.key});

  @override
  State<AdminScreenContent> createState() => _AdminScreenContentState();
}

class _AdminScreenContentState extends State<AdminScreenContent> {
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
                SizedBox(
                  width: size.width * .7,
                  child: Text(
                    "Decor Coins - Blumenau Centro",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 25),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
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
                ),
              ],
            ),
            SizedBox(height: size.height * .1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trabalhos recentes",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 25),
                ),
                GestureDetector(
                  child: Container(
                    height: size.height * .1,
                    width: size.width * .1,
                    decoration: BoxDecoration(
                      color: kDefaultPrimaryGradient[0],
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            RecentlyWorksWidget(size: size),
          ],
        ),
      ),
    );
  }
}
