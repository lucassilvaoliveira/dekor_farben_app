import 'package:dekor_farben_app/global/constants.dart';
import 'package:flutter/material.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 7, 14, 37),
      padding: const EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lucas Silva de Oliveira',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Active Status',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              )
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.admin_panel_settings,
                        color: kDefaultSubtitleColor,
                        size: 30,
                      ),
                      Text(
                        "Campaigns",
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: kDefaultSubtitleColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Settings',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: kDefaultSubtitleColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Log out',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
