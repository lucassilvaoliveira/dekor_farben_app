import 'package:dekor_farben_app/blocs/invoice/invoice_bloc.dart';
import 'package:dekor_farben_app/blocs/invoice/invoice_event.dart';
import 'package:dekor_farben_app/blocs/invoice/invoice_state.dart';
import 'package:dekor_farben_app/blocs/user/user_bloc.dart';
import 'package:dekor_farben_app/blocs/user/user_event.dart';
import 'package:dekor_farben_app/blocs/user/user_state.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/global/widgets/dialogs/on_error_dialog.dart';
import 'package:dekor_farben_app/global/widgets/dialogs/on_success_dialog.dart';
import 'package:dekor_farben_app/global/widgets/primary_select_option_button_widget.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:dekor_farben_app/screens/fullscreen_image/full_screen_image.dart';
import 'package:dekor_farben_app/screens/home_screen/home_screeen.dart';
import 'package:dekor_farben_app/screens/invoice_screen/invoice_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/entities/invoice.dart';
import '../../../../global/widgets/app_bar_widget.dart';

class InvoiceScreenBody extends StatefulWidget {
  const InvoiceScreenBody({super.key});

  @override
  State<InvoiceScreenBody> createState() => _InvoiceScreenBodyState();
}

class _InvoiceScreenBodyState extends State<InvoiceScreenBody> {
  @override
  void initState() {
    super.initState();
    final companyId = GlobalCompanyStore.store.state.company.id;
    BlocProvider.of<InvoiceBloc>(context)
        .add(ListInvoiceByCompanyEvent(companyId: companyId));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final company = GlobalCompanyStore.store.state.company;

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(
                  onBack: () => Navigator.push(context,
                      CupertinoPageRoute(builder: (context) =>
                          HomeScreen(company: company))),
                  title: 'Notas Fiscais'),
              Container(
                  height: size.height,
                  width: size.width,
                  margin: const EdgeInsets.only(top: 20),
                  child: BlocConsumer<InvoiceBloc, InvoiceState>(
                    listener: (context, state) {
                      if (state is InvoiceValidationSuccessState) {
                        onSuccessDialog(
                            aContext: context,
                            aTitle: "Nota fiscal validada!",
                            aSubtitle: "Os decor coins foram cadastrados na conta do cliente!",
                            onOkPressed: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const InvoiceScreen()))
                        );
                      }

                      if (state is InvoiceErrorState) {
                        onErrorDialog(
                            aContext: context,
                            aTitle: "Ocorreu um erro interno",
                            aSubtitle: "Tente novamente mais tarde.",
                            onOkPressed: () => Navigator.pop(context));
                      }
                    },
                    builder: (context, state) {
                      if (state is InvoiceLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is InvoiceListByCompanySuccessState) {
                        return _loadInvoices(state.invoices, size);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ))
            ],
          ),
        ));
  }

  Widget _loadInvoices(final List<Invoice> invoices, final Size size) {
    return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 0),
        itemCount: invoices.length,
        itemBuilder: (context, index) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 15),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(
                                2, 6), // changes position of shadow
                          ),
                        ],
                      ),
                      width: size.width * .3,
                      child: ClipOval(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: invoices[index].image != null ? Image.memory(invoices[index].image!) : SvgPicture.asset("assets/images/no-data-img.svg"),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (context) => FullScreenImage(image: invoices[index].image!)));
                        },
                        icon: Icon(
                          Icons.attach_file,
                          color: Colors.grey[400],
                          size: 45,
                    )),
                    Expanded(
                      child: _userWidgetSettings(invoices[index]),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  height: 1,
                  color: Colors.black.withOpacity(.3),
                ),
              ],
            ));
  }

  BlocConsumer<UserBloc, UserState> _userWidgetSettings(final Invoice invoice) {
    BlocProvider.of<UserBloc>(context)
        .add(GetOneUserEvent(userId: invoice.userId));

    return BlocConsumer<UserBloc, UserState>(
      builder: (BuildContext context, UserState state) {
        if (state is UserGetLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserGetOneSuccessState) {
          return _loadUserSettings(
              state.user.userName, state.user.userDocument, invoice.id);
        } else {
          return const SizedBox.shrink();
        }
      },
      listener: (BuildContext context, UserState state) {},
    );
  }

  Widget _loadUserSettings(final String name, final String document, final String invoiceId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          child: Text(name,
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 50,
          child: Text(document,
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.black)),
        ),
        PrimarySelectOptionButtonWidget(
          text: 'Validar',
          isOpacity: false,
          widgetColor: kDefaultPrimaryColor,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                        'Deseja mesmo validar a nota fiscal?'),
                    actions: [
                      TextButton(
                          onPressed: () =>
                              Navigator.pop(context),
                          child: const Text('Cancelar')),
                      TextButton(
                          onPressed: () => _validateInvoice(invoiceId),
                          child: const Text('Validar'))
                    ],
                  );
                });
          },
        ),
      ],
    );
  }

  void _validateInvoice(final String invoiceId) {
    BlocProvider.of<InvoiceBloc>(context)
        .add(ValidateInvoiceEvent(invoiceId: invoiceId));
  }
}

List<Map<String, dynamic>> sss = [
  {
    "name": "Kaliel Eduard",
    "image": "assets/images/borracha_liquida.png",
    "document": "102.879.709-57"
  },
  {
    "name": "Márcio de Freitas",
    "image": "assets/images/quartzo_mica.png",
    "document": "154.698.778-01"
  },
  {
    "name": "Larissa de Freitas",
    "image": "assets/images/cimento_diamantado_aveludado.png",
    "document": "456.872.112-69"
  },
  {
    "name": "Larissa de Freitas",
    "image": "assets/images/cimento_diamantado_aveludado.png",
    "document": "456.872.112-69"
  },
  {
    "name": "Larissa de Freitas",
    "image": "assets/images/cimento_diamantado_aveludado.png",
    "document": "456.872.112-69"
  },
];
