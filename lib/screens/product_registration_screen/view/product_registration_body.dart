import 'dart:io';

import 'package:dekor_farben_app/blocs/product/product_state.dart';
import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/global/widgets/default_camera_widget.dart';
import 'package:dekor_farben_app/global/widgets/dialogs/on_success_dialog.dart';
import 'package:dekor_farben_app/global/widgets/primary_select_option_button_widget.dart';
import 'package:dekor_farben_app/helpers/validators.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:dekor_farben_app/screens/home_screen/home_screeen.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../global/widgets/app_bar_widget.dart';
import '../../../blocs/product/product_bloc.dart';
import '../../../blocs/product/product_event.dart';
import '../../../infrastructure/product/create_product_request.dart';

class ProductRegistrationBody extends StatefulWidget {
  final Campaign campaign;

  const ProductRegistrationBody({super.key, required this.campaign});

  @override
  State<ProductRegistrationBody> createState() =>
      _ProductRegistrationBodyState();
}

class _ProductRegistrationBodyState extends State<ProductRegistrationBody> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  File? _image;

  late List<Map<String, dynamic>> settingsOptionsData;

  @override
  void initState() {
    super.initState();
    _image = null;

    settingsOptionsData = [
      {
        "icon": Icons.attach_money,
        "fieldName": "Preço",
        "controller": _priceController,
        "validator": (value) => Validators
            .nonNullValidator(value, "Preço")
            .tryGetError(),
        "keyboard": TextInputType.number
      },
      {
        "icon": Icons.pending_actions,
        "fieldName": "Nome do produto",
        "controller": _nameController,
        "validator": (value) => Validators
            .nonNullValidator(value, "Nome do produto")
            .tryGetError()
      },
      {
        "icon": Icons.add,
        "fieldName": "Descrição",
        "controller": _descriptionController,
        "validator": (value) => Validators
            .nonNullValidator(value, "Descrição")
            .tryGetError()
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (BuildContext context, ProductState state) {
        if (state is ProductCreateSuccessState) {
          onSuccessDialog(
              aContext: context,
              aTitle: 'Produto Criado!',
              aSubtitle: 'Você acabou de criar um produto!',
              onOkPressed: () => Navigator.push(context, CupertinoPageRoute(
                  builder: (context) => HomeScreen(company: GlobalCompanyStore.store.state.company))
              )
          );
        }
      },
      builder: (BuildContext context, state) {
        if (state is ProductLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return _loadForm();
        }
      },
    );
  }

  Widget _loadForm() {
    final size = MediaQuery.of(context).size;
    final containerHeight = size.height * .7;

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
            const AppBarWidget(title: 'Cadastro do produto'),
            SizedBox(
              height: containerHeight,
              width: size.width,
              child: Form(
                key: _formKey,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: containerHeight * .2),
                  separatorBuilder: (context, index) => const SizedBox.shrink(),
                  itemCount: settingsOptionsData.length,
                  itemBuilder: (context, index) => SizedBox(
                    width: size.width,
                    child: TextFieldWidget(
                      label: settingsOptionsData[index]["fieldName"],
                      icon: settingsOptionsData[index]["icon"],
                      controller: settingsOptionsData[index]["controller"],
                      formValidator: settingsOptionsData[index]["validator"],
                      keyboardType: settingsOptionsData[index]["keyboard"],
                      inputFormatters: settingsOptionsData[index]["mask"],
                    ),
                  ),
                ),
              ),
            ),
            DefaultCameraWidget(height: 50, width: 50, onImageSelected: onImageSelected),
            const SizedBox(height: 20),
            PrimarySelectOptionButtonWidget(
              widgetColor: kDefaultPrimaryColor,
              text: 'Salvar',
              isOpacity: _image == null,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final company = GlobalCompanyStore.store.state.company;

                  BlocProvider.of<ProductBloc>(context).add(CreateProductEvent(
                    file: _image != null ? _image! : File("assets/images/person-round.png"),
                      request: CreateProductRequest(
                          companyId: company.id,
                          campaignId: widget.campaign.id,
                          name: _nameController.text,
                          description: _descriptionController.text,
                          price: double.parse(_priceController.text)
                      ))
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  DateTime formatDate(final String date) {
    DateTime formattedDate = DateFormat('dd/MM/yyyy')
        .parse(date);

    return DateTime(
        formattedDate.year,
        formattedDate.month,
        formattedDate.day
    );
  }
}
