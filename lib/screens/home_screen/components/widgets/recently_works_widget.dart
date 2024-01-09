import 'package:dekor_farben_app/blocs/recent_work/recent_work_bloc.dart';
import 'package:dekor_farben_app/blocs/recent_work/recent_work_event.dart';
import 'package:dekor_farben_app/blocs/recent_work/recent_work_state.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/page_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/entities/recent_work.dart';
import '../../../../global/constants.dart';
import '../../../../global/widgets/camera_widget.dart';

class RecentlyWorksWidget extends StatefulWidget {
  final List<RecentWork> recentWorks;

  const RecentlyWorksWidget({super.key, required this.recentWorks});

  @override
  State<RecentlyWorksWidget> createState() => _RecentlyWorksWidgetState();
}

class _RecentlyWorksWidgetState extends State<RecentlyWorksWidget> {
  final _controller = PageController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RecentWorkBloc>(context)
        .add(GetRecentWorkAssetsEvent(recentWorks: widget.recentWorks));
  }

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
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () {}, child: const Text('Salvar'))
            ],
          ),
        );

    return BlocBuilder<RecentWorkBloc, RecentWorkState>(
        builder: (BuildContext context, state) {
      if (state is RecentWorkLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is RecentWorkGetAssetsSuccessState) {
        final List<RecentWork> recentWorks = state.recentWorks;

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    "Trabalhos recentes",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  userType == 'company'
                      ? Container(
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
                      : const SizedBox()
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
                width: size.width,
                child: _loadRecentWorksImages(size, recentWorks, _controller)),
            recentWorks.isNotEmpty
                ? PageIndicatorWidget(
                    controller: _controller, count: recentWorks.length)
                : const SizedBox.shrink(),
            const SizedBox(height: 20)
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}

Widget _loadRecentWorksImages(final Size size,
    final List<RecentWork> recentWorks, final PageController controller) {
  if (recentWorks.isNotEmpty) {
    return PageView.builder(
        itemBuilder: (context, index) => SizedBox(
              height: size.height * .4,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        recentWorks[index].recentWorkDate.toString(),
                        style: const TextStyle(color: kDefaultSubtitleColor),
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
                      child: _loadImage(recentWorks, index, size)),
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
        controller: controller,
        itemCount: recentWorks.length);
  } else {
    return Container(
        height: 280,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(2, 6), // changes position of shadow
            ),
          ],
        ),
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: SvgPicture.asset("assets/images/no-data-img.svg"),
      ),
    );
  }
}

Widget _loadImage(
    final List<RecentWork> recentWorks, final int index, final Size size) {
  if (recentWorks[index].image != null) {
    return Image.memory(
      recentWorks[index].image!,
      width: size.width * .25,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const SizedBox.shrink();
      },
    );
  } else {
    return Center(
        child: Center(
            child: Container(
                height: 280,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(2, 6), // changes position of shadow
                    ),
                  ],
                )
            )
        )
    );
  }
}
