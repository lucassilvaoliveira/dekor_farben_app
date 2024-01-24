import 'package:dekor_farben_app/blocs/campaign/campaign_bloc.dart';
import 'package:dekor_farben_app/blocs/campaign/campaign_event.dart';
import 'package:dekor_farben_app/blocs/campaign/campaign_state.dart';
import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/global/widgets/dialogs/on_error_dialog.dart';
import 'package:dekor_farben_app/global/widgets/dialogs/on_success_dialog.dart';
import 'package:dekor_farben_app/infrastructure/campaign/update_campaign_request.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../global/constants.dart';
import '../../../../global/widgets/app_bar_widget.dart';
import '../../../../global/widgets/primary_select_option_button_widget.dart';
import '../../../home_screen/home_screeen.dart';
import '../../../onboarding_screen/components/widgets/text_field_widget.dart';
import '../../../product_detail_screen/product_detail_screen.dart';

class CampaignEditBody extends StatefulWidget {
  final Campaign campaign;

  const CampaignEditBody({super.key, required this.campaign});

  @override
  State<CampaignEditBody> createState() => _CampaignEditBodyState();
}

class _CampaignEditBodyState extends State<CampaignEditBody> {
  late List<Map<String, dynamic>> settingsOptionsData;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _rewardController;
  late TextEditingController _initialDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.campaign.campaignName);
    _descriptionController =
        TextEditingController(text: widget.campaign.campaignDescription);
    _rewardController =
        TextEditingController(text: widget.campaign.campaignReward.toString());
    _initialDateController = TextEditingController(
        text: DateFormat("dd/MM/yyyy")
            .format(widget.campaign.campaignInitialDate));
    _endDateController = TextEditingController(
        text: DateFormat("dd/MM/yyyy").format(widget.campaign.campaignEndDate));

    settingsOptionsData = [
      {
        "icon": Icons.star,
        "fieldName": "Decor coins",
        "controller": _rewardController,
        "value": _rewardController.text
      },
      {
        "icon": Icons.pending_actions,
        "fieldName": "Nome da campanha",
        "controller": _nameController,
        "value": _nameController.text
      },
      {
        "icon": Icons.calendar_month,
        "fieldName": "Data de início",
        "controller": _initialDateController,
        "value": _initialDateController.text
      },
      {
        "icon": Icons.calendar_month,
        "fieldName": "Data final",
        "controller": _endDateController,
        "value": _endDateController.text
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
    return BlocConsumer<CampaignBloc, CampaignState>(
        listener: (BuildContext context, CampaignState state) {
      if (state is CampaignUpdateSuccessState) {
        final company = GlobalCompanyStore.store.state.company;

        onSuccessDialog(
            aContext: context,
            aTitle: "Campanha atualizada!",
            aSubtitle: "",
            onOkPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => HomeScreen(company: company))));
      } else if (state is CampaignDeleteSuccessState) {
        final company = GlobalCompanyStore.store.state.company;

        onSuccessDialog(
            aContext: context,
            aTitle: "Campanha deletada!",
            aSubtitle: "",
            onOkPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => HomeScreen(company: company))));
      } else if (state is CampaignErrorState){
        onErrorDialog(
            aContext: context,
            aTitle: "Ocorreu um erro interno!",
            aSubtitle: "Tente novamente mais tarde.",
            onOkPressed: () => Navigator.pop(context));
      }
    }, builder: (BuildContext context, CampaignState state) {
      if (state is CampaignLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return _loadForm();
      }
    });
  }

  Widget _loadForm() {
    final size = MediaQuery.of(context).size;
    final mainContainerHeight = size.height * .62;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 60),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarWidget(title: 'Campanha'),
            SizedBox(
                height: mainContainerHeight,
                width: size.width,
                child: ListView.separated(
                  padding:
                      EdgeInsets.symmetric(vertical: mainContainerHeight * .15),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 1),
                  itemCount: settingsOptionsData.length,
                  itemBuilder: (context, index) => SizedBox(
                    width: size.width,
                    child: TextFieldWidget(
                      label: settingsOptionsData[index]["fieldName"],
                      icon: settingsOptionsData[index]["icon"],
                      controller: settingsOptionsData[index]["controller"],
                    ),
                  ),
                )),
            SizedBox(
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
                            BlocProvider.of<CampaignBloc>(context).add(
                                UpdateCampaignEvent(
                                    request: UpdateCampaignRequest(
                                        id: widget.campaign.id,
                                        name: _nameController.text,
                                        description:
                                            _descriptionController.text,
                                        reward:
                                            int.parse(_rewardController.text),
                                        initialDate: formatDate(
                                            _initialDateController.text),
                                        endDate: formatDate(
                                            _endDateController.text))));
                          }),
                      const SizedBox(height: 20),
                      PrimarySelectOptionButtonWidget(
                          widgetColor: kDefaultPrimaryColor,
                          text: 'Ver Produtos',
                          isOpacity: false,
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                        campaign: widget.campaign)));
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
                                        'Deseja mesmo deletar a campanha?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Cancelar')),
                                      TextButton(
                                          onPressed: () => deleteCampaign(),
                                          child: const Text('Deletar'))
                                    ],
                                  );
                                });
                          })
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void deleteCampaign() {
    return BlocProvider.of<CampaignBloc>(context)
        .add(DeleteCampaignEvent(id: widget.campaign.id));
  }

  DateTime formatDate(final String date) {
    DateTime formattedDate = DateFormat('dd/MM/yyyy').parse(date);

    return DateTime(formattedDate.year, formattedDate.month, formattedDate.day);
  }
}
