import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../global/widgets/camera_widget.dart';
import 'package:dekor_farben_app/core/usecases/company/get_company_asset_use_case.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/company_http_repository_impl.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';

class CompanyPicWidget extends StatefulWidget {
  const CompanyPicWidget({super.key});

  @override
  _CompanyPicWidgetState createState() => _CompanyPicWidgetState();
}

class _CompanyPicWidgetState extends State<CompanyPicWidget> {
  File? image;

  @override
  Widget build(BuildContext context) {
    final companyStore = GlobalCompanyStore.store;
    final aCompany = companyStore.state.company;

    final assetUseCase = GetCompanyAssetUseCase(repository: CompanyHttpRepositoryImpl());

    Future<ImageProvider> getImage() async {
      final assetResponse = await assetUseCase.call(companyId: aCompany.id);

      if (assetResponse.isSuccess()) {
        final assetJson = assetResponse.tryGetSuccess();
        final imageBytes = assetJson?.body["image"];
        return MemoryImage(imageBytes);
      } else {
        return const AssetImage("assets/images/person-round.png");
      }
    }

    return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          FutureBuilder<ImageProvider>(
            future: getImage(),
            builder: (BuildContext context, AsyncSnapshot<ImageProvider> snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(.3),
                  backgroundImage: image != null ? FileImage(image!) : snapshot.data,
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(.3),
                    child: const CircularProgressIndicator()
                );
              } else {
                return CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(.3),
                  backgroundImage: const AssetImage("assets/images/person-round.png"),
                );
              }
            },
          ),
          Positioned(
              right: -16,
              bottom: 0,
              child: CameraWidget(width: 50, height: 50, image: image)
          )
        ],
      ),
    );
  }
}
