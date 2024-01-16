import 'dart:io';

import 'package:dekor_farben_app/blocs/invoice/invoice_event.dart';
import 'package:dekor_farben_app/blocs/invoice/invoice_state.dart';
import 'package:dekor_farben_app/core/entities/campaign.dart';
import 'package:dekor_farben_app/core/entities/invoice.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/global/widgets/dialogs/on_success_dialog.dart';
import 'package:dekor_farben_app/global/widgets/primary_select_option_button_widget.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:dekor_farben_app/screens/home_screen/components/widgets/page_indicator_widget.dart';
import 'package:dekor_farben_app/screens/home_screen/home_screeen.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/reducer/global_user_store.dart';
import 'package:dekor_farben_app/screens/product_details_screen.dart/components/widgets/product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../blocs/invoice/invoice_bloc.dart';
import '../../../../global/widgets/app_bar_widget.dart';
import '../../../../global/widgets/default_camera_widget.dart';

class CampaignDetailsBody extends StatefulWidget {
  final Campaign campaign;

  const CampaignDetailsBody({super.key, required this.campaign});

  @override
  State<StatefulWidget> createState() => _CampaignDetailsBodySate();
}

class _CampaignDetailsBodySate extends State<CampaignDetailsBody> {
  final _controller = PageController();

  final user = GlobalUserStore.store.state.user;
  final company = GlobalCompanyStore.store.state.company;

  File? _image;

  @override
  void initState() {
    super.initState();
    _image = null;
  }

  @override
  Widget build(BuildContext context) {
    final Campaign aCampaign = widget.campaign;
    final size = MediaQuery.of(context).size;

    void onImageSelected(File? selectedImage) {
      setState(() {
        _image = selectedImage;
      });
    }

    return BlocConsumer<InvoiceBloc, InvoiceState>(listener: (context, state) {
      if (state is InvoiceCreateSuccessState) {
        onSuccessDialog(
            aContext: context,
            aTitle: "Nota fiscal enviada!",
            aSubtitle: "Sua nota fiscal foi enviada para análise, agora basta aguardar seus decor coins cairem na conta!",
            onOkPressed: () => Navigator.push(context, CupertinoPageRoute(
                builder: (context) => HomeScreen(company: company))
            )
        );
      }
    }, builder: (context, state) {
      if (state is InvoiceLoadingState) {
        return const Center(child: CircularProgressIndicator());
      }

      return SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 60),
              height: size.height * .22,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarWidget(title: 'Campanha ${aCampaign.campaignName}'),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        aCampaign.campaignDescription,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 20),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
              width: size.width,
              child: Text(
                'Produtos da campanha',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              height: 140,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(2, 6), // changes position of shadow
                  ),
                ],
              ),
              child: aCampaign.products.isNotEmpty
                  ? PageView.builder(
                      itemCount: aCampaign.products.length,
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      itemBuilder: (_, index) => ProductWidget(
                        size: size,
                        product: aCampaign.products[index],
                      ),
                    )
                  : SvgPicture.asset("assets/images/no-data-img.svg"),
            ),
            const SizedBox(
              height: 20,
            ),
            aCampaign.products.isNotEmpty
                ? PageIndicatorWidget(
                    controller: _controller, count: aCampaign.products.length)
                : const SizedBox.shrink(),
            Flexible(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 370,
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Já realizou a compra? Anexe a nota fiscal para receber a sua recompensa',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PrimarySelectOptionButtonWidget(
                            widgetColor: kDefaultPrimaryColor,
                            text: 'Enviar nota fiscal',
                            isOpacity: _image == null,
                            onPressed: () => onSendInvoice(_image)),
                        DefaultCameraWidget(
                            height: 50,
                            width: 50,
                            onImageSelected: onImageSelected),
                      ],
                    ),
                    const SizedBox(height: 40)
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  void onSendInvoice(File? selectedImage) {
    final Invoice invoice = Invoice(
        id: "",
        companyId: company.id,
        userId: user.id,
        campaignId: widget.campaign.id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());

    BlocProvider.of<InvoiceBloc>(context).add(CreateInvoiceEvent(
        invoice: invoice,
        image:
            _image != null ? _image! : File("assets/images/person-round.png")));
  }
}
