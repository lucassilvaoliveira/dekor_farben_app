import 'package:flutter/material.dart';

class RecentlyWorksWidget extends StatelessWidget {
  const RecentlyWorksWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * .5,
      width: size.width,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
          height: size.height * .4,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kaliel Eduard Rosa",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "13/05/2023",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                height: size.height * .4,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
