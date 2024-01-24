import 'dart:io';

import 'package:dekor_farben_app/blocs/recent_work/recent_work_bloc.dart';
import 'package:dekor_farben_app/blocs/recent_work/recent_work_state.dart';
import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/core/entities/recent_work.dart';
import 'package:dekor_farben_app/global/widgets/default_camera_widget.dart';
import 'package:dekor_farben_app/global/widgets/dialogs/on_success_dialog.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global/constants.dart';
import '../../../../global/widgets/app_bar_widget.dart';
import '../../../../global/widgets/primary_select_option_button_widget.dart';
import '../../../blocs/recent_work/recent_work_event.dart';
import '../../../infrastructure/recent_work/update_recent_work_request.dart';
import '../../home_screen/home_screeen.dart';
import '../../onboarding_screen/components/widgets/text_field_widget.dart';

class RecentWorkEditBody extends StatefulWidget {
  final RecentWork recentWork;

  const RecentWorkEditBody({super.key, required this.recentWork});

  @override
  State<RecentWorkEditBody> createState() => _RecentWorkEditBodyState();
}

class _RecentWorkEditBodyState extends State<RecentWorkEditBody> {
  late List<Map<String, dynamic>> settingsOptionsData;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _dateController;

  File? _image;

  @override
  void initState() {
    super.initState();

    _image = null;

    _dateController = TextEditingController(text: widget.recentWork.recentWorkDate.toString());

    settingsOptionsData = [
      {
        "icon": Icons.calendar_today_outlined,
        "fieldName": "Data do trabalho recente",
        "controller": _dateController,
        "value": _dateController.text
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecentWorkBloc, RecentWorkState>(
        listener: (BuildContext context, RecentWorkState state) {
          if (state is RecentWorkUpdateSuccessState) {
            final company = GlobalCompanyStore.store.state.company;

            onSuccessDialog(
                aContext: context,
                aTitle: "Trabalho recente atualizado!",
                aSubtitle: "",
                onOkPressed: () => Navigator.push(context, CupertinoPageRoute(
                    builder: (context) => HomeScreen(company: company))
                )
            );
          } else if (state is RecentWorkDeleteSuccessState) {
            final company = GlobalCompanyStore.store.state.company;

            onSuccessDialog(
                aContext: context,
                aTitle: "Trabalho recente deletado!",
                aSubtitle: "",
                onOkPressed: () => Navigator.push(context, CupertinoPageRoute(
                    builder: (context) => HomeScreen(company: company))
                )
            );
          }
        },
        builder: (BuildContext context, RecentWorkState state) {
          if (state is RecentWorkLoadingState) {
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
            const AppBarWidget(title: 'Trabalho recente'),
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
              margin: EdgeInsets.only(top: mainContainerHeight * .4),
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
                              BlocProvider.of<RecentWorkBloc>(context).add(UpdateRecentWorkEvent(
                                  request: UpdateRecentWorkRequest(
                                    date: widget.recentWork.recentWorkDate,
                                    image: _image != null ? _image! : File("assets/images/person-round.png"),
                                    id: widget.recentWork.id,
                                    companyId: widget.recentWork.companyId,
                                  )));
                            }),
                        const SizedBox(height: 20),
                        PrimarySelectOptionButtonWidget(
                            widgetColor: Colors.red,
                            text: 'Excluir',
                            isOpacity: false,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Deseja mesmo deletar o trabalho recente?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Cancelar')),
                                        TextButton(
                                            onPressed: () => deleteRecentWork(),
                                            child: const Text('Deletar'))
                                      ],
                                    );
                                  });
                            })
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

  void deleteRecentWork() {
    return BlocProvider.of<RecentWorkBloc>(context)
        .add(DeleteRecentWorkEvent(id: widget.recentWork.id));
  }
}

