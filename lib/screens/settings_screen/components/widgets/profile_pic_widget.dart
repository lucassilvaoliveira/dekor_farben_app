import 'package:dekor_farben_app/global/widgets/camera_widget.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/reducer/global_user_store.dart';
import 'package:flutter/material.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userStore = GlobalUserStore.store;
    final anUser = userStore.state.user;

    return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(.3),
            backgroundImage:
                const AssetImage("assets/images/Profile Image.png"),
          ),
        ],
      ),
    );
  }
}
