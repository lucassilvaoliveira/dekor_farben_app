import 'dart:io';

import 'package:dekor_farben_app/core/usecases/company/update_company_asset_use_case.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/company_http_repository_impl.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

//ignore: must_be_immutable
class CameraWidget extends StatefulWidget {
  final double height;
  final double width;

  File? image;

  CameraWidget(
      {super.key, this.image, required this.height, required this.width});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  final ImagePicker _imagePicker = ImagePicker();
  final updateUseCase =
      UpdateCompanyAssetUseCase(repository: CompanyHttpRepositoryImpl());
  final companyStore = GlobalCompanyStore.store;

  _CameraWidgetState();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var source = ImageSource.gallery;
        XFile? image =
            await _imagePicker.pickImage(source: source, imageQuality: 50);

        if (image != null) {
          final aCompany = companyStore.state.company;
          final updateAssetResponse =
              await updateUseCase.call(companyId: aCompany.id, aFile: image);

          setState(() {
            if (updateAssetResponse.isSuccess()) {
              widget.image = File(image.path);
            }
          });
        }
      },
      child: ClipOval(
        child: Container(
          height: widget.height,
          width: widget.width,
          color: Colors.white,
          child: Icon(
            Icons.camera_alt_rounded,
            size: 100 / widget.width * .6 * widget.height * .6,
            color: kDefaultPrimaryColor,
          ),
        ),
      ),
    );
  }
}
