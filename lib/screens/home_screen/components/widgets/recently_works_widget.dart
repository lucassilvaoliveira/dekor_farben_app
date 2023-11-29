import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/page_indicator_widget.dart';
import 'package:flutter/material.dart';

class RecentlyWorksWidget extends StatelessWidget {
  RecentlyWorksWidget({
    super.key,
    required this.size,
  });

  final Size size;
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: userType == "admin" ? size.height * .6 : size.height * .48,
            width: size.width,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              children: [
                for (var i = 0; i < 3; i++)
                  SizedBox(
                    height: size.height * .4,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "13/05/2023",
                              style: TextStyle(color: kDefaultSubtitleColor),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          height: size.height * .4,
                          width: size.width,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Image.asset(
                            "assets/images/cimento-queimado.jpg",
                            width: size.width,
                          ),
                        ),
                        if (userType == "admin")
                          Center(
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: size.width * .1,
                            ),
                          )
                      ],
                    ),
                  ),
              ],
            )),
        PageIndicatorWidget(controller: _controller, count: 3),
        const SizedBox(height: 20)
      ],
    );
  }
}
