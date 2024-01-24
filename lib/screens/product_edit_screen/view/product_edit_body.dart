import 'dart:io';

import 'package:dekor_farben_app/blocs/product/product_state.dart';
import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/global/widgets/default_camera_widget.dart';
import 'package:dekor_farben_app/global/widgets/dialogs/on_success_dialog.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global/constants.dart';
import '../../../../global/widgets/app_bar_widget.dart';
import '../../../../global/widgets/primary_select_option_button_widget.dart';
import '../../../blocs/product/product_bloc.dart';
import '../../../blocs/product/product_event.dart';
import '../../../infrastructure/product/update_product_request.dart';
import '../../home_screen/home_screeen.dart';
import '../../onboarding_screen/components/widgets/text_field_widget.dart';

class ProductEditBody extends StatefulWidget {
  final Product product;

  const ProductEditBody({super.key, required this.product});

  @override
  State<ProductEditBody> createState() => _ProductEditBodyState();
}

class _ProductEditBodyState extends State<ProductEditBody> {
  late List<Map<String, dynamic>> settingsOptionsData;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;

  File? _image;

  @override
  void initState() {
    super.initState();

    _image = null;

    _nameController = TextEditingController(text: widget.product.productName);
    _descriptionController = TextEditingController(text: widget.product.productDescription);
    _priceController = TextEditingController(text: widget.product.productPrice.toString());

    settingsOptionsData = [
      {
        "icon": Icons.star,
        "fieldName": "Preço",
        "controller": _priceController,
        "value": _priceController.text
      },
      {
        "icon": Icons.pending_actions,
        "fieldName": "Nome do produto",
        "controller": _nameController,
        "value": _nameController.text
      },
      {
        "icon": Icons.add,
        "fieldName": "Descrição",
        "controller": _descriptionController,
        "value": _descriptionController.text
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
        listener: (BuildContext context, ProductState state) {
          if (state is ProductUpdateSuccessState) {
            final company = GlobalCompanyStore.store.state.company;

            onSuccessDialog(
                aContext: context,
                aTitle: "Produto atualizado!",
                aSubtitle: "",
                onOkPressed: () => Navigator.push(context, CupertinoPageRoute(
                    builder: (context) => HomeScreen(company: company))
                )
            );
          }
        },
        builder: (BuildContext context, ProductState state) {
          if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _loadForm();
          }
        }
    );
  }

  Widget _loadForm() {
    final size = MediaQuery.of(context).size;
    final mainContainerHeight = size.height * .45;

    void onImageSelected(File? selectedImage) {
      setState(() {
        _image = selectedImage;
      });
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 60),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarWidget(title: 'Produto'),
            SizedBox(
                height: mainContainerHeight,
                width: size.width,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: mainContainerHeight * .25),
                  separatorBuilder: (context, index) => const SizedBox(height: 1),
                  itemCount: settingsOptionsData.length,
                  itemBuilder: (context, index) =>
                      SizedBox(
                        width: size.width,
                        child: TextFieldWidget(
                          label: settingsOptionsData[index]["fieldName"],
                          icon: settingsOptionsData[index]["icon"],
                          controller: settingsOptionsData[index]["controller"],
                        ),
                      ),
                )
            ),
            DefaultCameraWidget(
                height: 80,
                width: 80,
                onImageSelected: onImageSelected
            ),
            Container(
              margin: EdgeInsets.only(top: mainContainerHeight * .5),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimarySelectOptionButtonWidget(
                            widgetColor: kDefaultPrimaryColor,
                            text: 'Salvar',
                            isOpacity: false,
                            onPressed: () {
                          final company = GlobalCompanyStore.store.state.company;

                          BlocProvider.of<ProductBloc>(context).add(UpdateProductEvent(
                              _image != null ? _image! : File("assets/images/person-round.png"),
                              request: UpdateProductRequest(
                            id: widget.product.id,
                            campaignId: widget.product.campaignId,
                            companyId: company.id,
                            name: _nameController.text,
                            description: _descriptionController.text,
                            price: double.parse(_priceController.text),
                          )));
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

