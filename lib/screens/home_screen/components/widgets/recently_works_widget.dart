import 'package:dekor_farben_app/screens/home_screen/components/widgets/page_indicator_widget.dart';
import 'package:flutter/material.dart';

import '../../../../global/constants.dart';
import '../../../../global/widgets/camera_widget.dart';

class RecentlyWorksWidget extends StatefulWidget {
  const RecentlyWorksWidget({super.key});

  @override
  State<RecentlyWorksWidget> createState() => _RecentlyWorksWidgetState();
}

class _RecentlyWorksWidgetState extends State<RecentlyWorksWidget> {

  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Novo trabalho recente'),
        content: SizedBox(
          height: size.height * .2,
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(hintText: 'Data'),
              ),
              const SizedBox(height: 20),
              CameraWidget(height: 40, width: 40)
            ],
          ),
        ),

        actions: [
          TextButton(onPressed: () {}, child: const Text('Salvar'))
        ],
      ),
    );


    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Text(
                "Trabalhos recentes",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  child: ClipOval(
                    child: Container(
                      width: 30,
                      height: 30,
                      color: kDefaultPrimaryColor,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  onTap: () => openDialog(),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
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
