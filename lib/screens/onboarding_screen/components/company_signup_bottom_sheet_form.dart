import 'package:dekor_farben_app/blocs/company/company_event.dart';
import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/core/usecases/user/create_user_use_case.dart';
import 'package:dekor_farben_app/helpers/validators.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/user_http_repository_impl.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/components/reducer/global_company_store.dart';
import 'package:dekor_farben_app/screens/home_screen/home_screeen.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uuid/uuid.dart';

import '../../../blocs/user/user_bloc.dart';
import '../../../blocs/user/user_state.dart';
import '../../../global/constants.dart';
import '../../../global/widgets/primary_button_widget.dart';

class CompanySignupBottomSheetForm extends StatefulWidget {
  final createUserUseCase =
  CreateUserUseCase(repository: UserHttpRepositoryImpl());

  final PageController pageController;

  CompanySignupBottomSheetForm({super.key, required this.pageController});

  @override
  State<CompanySignupBottomSheetForm> createState() => _SignUpBottomSheetFormState();
}

class _SignUpBottomSheetFormState extends State<CompanySignupBottomSheetForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  doSignup(BuildContext context) {
    final String aName = _nameController.text;
    final String anEmail = _emailController.text;
    final String aCnpj = _cnpjController.text;
    final String aPhone = _phoneController.text;
    final String aPassword = _passwordController.text;

    final User anUser = User(
        id: const Uuid().v4(),
        userType: "company",
        userEmail: anEmail,
        userPassword: aPassword,
        userName: aName,
        telephoneNumber: aPhone
            .replaceAll("(", "")
            .replaceAll(")", "")
            .replaceAll(" ", "")
            .replaceAll("-", ""),
        userBirthday: null,
        userDocument: aCnpj.replaceAll('.', '').replaceAll('-', '').replaceAll('/', ''),
        userAvatarPath: null,
        userPoints: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());

    BlocProvider.of<UserBloc>(context).add(CreateUserEvent(user: anUser));
  }

  final _cnpjMaskFormatter = MaskTextInputFormatter(
      mask: "##.###.###/####-##",
      type: MaskAutoCompletionType.lazy
  );

  final _telephoneNumberMaskFormatter = MaskTextInputFormatter(
      mask: "(##) #####-####",
      type: MaskAutoCompletionType.lazy
  );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserCreateSuccessState) {
          final globalCompanyStore = GlobalCompanyStore.store;

          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => HomeScreen(
                  company: globalCompanyStore.state.company
              ),
            ),
          );
        } else if (state is UserAlreadyRegisteredState) {
          showErrorAlert(context, "Usuário com os dados já registrado!", "Tente novamente com outros dados.");
        } else if (state is UserCreateOnErrorState) {
          showErrorAlert(context, "Ocorreu Algo Inesperado!", "Tente novamente!");
        }
      },
      builder: (BuildContext context, UserState state) {
        if (state is UserCreateLoadingState) {
          return const Center(
            child: SpinKitCircle(
              color: kDefaultPrimaryColor,
              size: 100,
            ),
          );
        } else {
          return _loadSignupForm(size);
        }
      },
    );
  }

  _loadSignupForm(final Size size) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Crie sua conta',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge),
                const SizedBox(height: 25),
                TextFieldWidget(
                    label: 'Nome',
                    icon: Icons.person,
                    controller: _nameController,
                    formValidator: (name) => Validators
                        .nameValidator(name)
                        .tryGetError()
                ),
                TextFieldWidget(
                    label: 'Email',
                    icon: Icons.email,
                    controller: _emailController,
                    formValidator: (value) => Validators
                        .emailValidator(value)
                        .tryGetError()
                ),
                TextFieldWidget(
                  label: 'CNPJ',
                  icon: Icons.key,
                  controller: _cnpjController,
                  keyboardType: TextInputType.number,
                  formValidator: (value) => Validators
                      .cnpjValidator(value)
                      .tryGetError(),
                  inputFormatters: [
                    _cnpjMaskFormatter
                  ],
                ),
                TextFieldWidget(
                  label: 'Telefone',
                  icon: Icons.email,
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  formValidator: (value) => Validators
                      .telephoneValidator(value)
                      .tryGetError(),
                  inputFormatters: [_telephoneNumberMaskFormatter],
                ),
                TextFieldWidget(
                    label: 'Senha',
                    icon: Icons.lock,
                    hidden: true,
                    controller: _passwordController,
                    formValidator: (value) => Validators
                        .passwordValidator(value)
                        .tryGetError()
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.pageController.page == 1) {
                          widget.pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.ease);
                        }
                      },
                      child: Text('Fazer Login',
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 20)),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: size.width * 0.4,
                      child: PrimaryButtonWidget(
                          text: 'Criar',
                          onPressed: () => {
                            if (_formKey.currentState!.validate())
                              {doSignup(context)}
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showErrorAlert(final BuildContext context, final String title, final String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 32, vertical: 16),
          margin: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: const Color(0xff2A303E),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "assets/images/alert_icon.svg",
                width: 72,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                title,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                    fontSize: 25, color: const Color(0xffEC5B5B)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white, fontSize: 17),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5BEC84),
                        foregroundColor: const Color(0xff2A303E),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 32),
                      ),
                      child: const Text('OK'))
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
