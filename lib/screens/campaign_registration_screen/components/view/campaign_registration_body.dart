import 'package:dekor_farben_app/blocs/campaign/campaign_bloc.dart';
import 'package:dekor_farben_app/blocs/campaign/campaign_event.dart';
import 'package:dekor_farben_app/blocs/campaign/campaign_state.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/global/widgets/primary_select_option_button_widget.dart';
import 'package:dekor_farben_app/infrastructure/campaign/create_campaign_request.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../global/widgets/app_bar_widget.dart';

class CampaignRegistrationBody extends StatefulWidget {
  const CampaignRegistrationBody({super.key});

  @override
  State<CampaignRegistrationBody> createState() =>
      _CampaignRegistrationBodyState();
}

class _CampaignRegistrationBodyState extends State<CampaignRegistrationBody> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _rewardController = TextEditingController();
  final _initialDateController = TextEditingController();
  final _endDateController = TextEditingController();

  late List<Map<String, dynamic>> settingsOptionsData;

  @override
  void initState() {
    super.initState();
    settingsOptionsData = [
      {
        "icon": Icons.star,
        "fieldName": "Decor coins",
        "value": "",
        "controller": _rewardController
      },
      {
        "icon": Icons.pending_actions,
        "fieldName": "Nome da campanha",
        "value": "",
        "controller": _nameController
      },
      {
        "icon": Icons.calendar_month,
        "fieldName": "Data de início",
        "value": "",
        "controller": _initialDateController
      },
      {
        "icon": Icons.calendar_month,
        "fieldName": "Data final",
        "value": "",
        "controller": _endDateController
      },
      {
        "icon": Icons.add,
        "fieldName": "Descrição",
        "value": "",
        "controller": _descriptionController
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignBloc, CampaignState>(
      builder: (BuildContext context, state) {
        if (state is CampaignLoadingState) {
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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 60),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarWidget(title: 'Cadastro da campanha'),
            SizedBox(
              height: containerHeight,
              width: size.width,
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
                  ),
                ),
              ),
            ),
            PrimarySelectOptionButtonWidget(
              widgetColor: kDefaultPrimaryColor,
              text: 'Salvar',
              isOpacity: false,
              onPressed: () {
                BlocProvider.of<CampaignBloc>(context).add(CreateCampaignEvent(
                    request: CreateCampaignRequest(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        reward: int.parse(_rewardController.text),
                        initialDate: formatDate(_initialDateController.text),
                        endDate: formatDate(_endDateController.text),
                        isOpen: true,
                        isActive: true)));
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
