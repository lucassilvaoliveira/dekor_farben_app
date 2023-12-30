import 'package:dekor_farben_app/blocs/user_event.dart';
import 'package:dekor_farben_app/blocs/user_state.dart';
import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/core/usecases/user/create_user_use_case.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/user_http_repository_impl.dart';
import 'package:dekor_farben_app/screens/choose_company_screen/choose_company_screen.dart';
import 'package:dekor_farben_app/screens/onboarding_screen/components/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../blocs/user_bloc.dart';
import '../../../global/widgets/primary_button_widget.dart';

class SignUpBottomSheetForm extends StatelessWidget {
  final createUserUseCase =
      CreateUserUseCase(repository: UserHttpRepositoryImpl());
  final PageController pageController;

  SignUpBottomSheetForm({super.key, required this.pageController});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  doSignup(BuildContext context) {
    final String aName = _nameController.text;
    final String anEmail = _emailController.text;
    final String aCpf = _cpfController.text;
    final String aBirthday = _birthdayController.text;
    final String aPhone = _phoneController.text;
    final String aPassword = _passwordController.text;

    DateTime birthday = DateFormat('dd/MM/yyyy').parse(aBirthday);
    DateTime formattedDate =
        DateTime(birthday.year, birthday.month, birthday.day);

    final User anUser = User(
        id: const Uuid().v4(),
        userType: "user",
        userEmail: anEmail,
        userPassword: aPassword,
        userName: aName,
        telephoneNumber: aPhone,
        userBirthday: formattedDate.toUtc(),
        userCpf: int.parse(aCpf),
        userPoints: 0,
        userAvatarPath: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());

    BlocProvider.of<UserBloc>(context).add(CreateUserEvent(user: anUser));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserCreateSuccessState) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const ChooseCompanyScreen(),
            ),
          );
        } else if (state is UserCreateOnErrorState) {
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
                          'Ocorreu algo inesperado!',
                          style: Theme.of(context)
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
                          'Tente Novamente!',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
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
      },
      child: Container(
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: mediaQuery.viewInsets,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Crie sua conta',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 25),
                TextFieldWidget(
                    label: 'Nome',
                    icon: Icons.person,
                    controller: _nameController),
                TextFieldWidget(
                    label: 'Email',
                    icon: Icons.email,
                    controller: _emailController),
                TextFieldWidget(
                    label: 'CPF', icon: Icons.key, controller: _cpfController),
                TextFieldWidget(
                    label: 'Data de nascimento',
                    icon: Icons.cake,
                    controller: _birthdayController),
                TextFieldWidget(
                    label: 'Telefone',
                    icon: Icons.email,
                    controller: _phoneController),
                TextFieldWidget(
                  label: 'Senha',
                  icon: Icons.lock,
                  hidden: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (pageController.page == 1) {
                          pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.ease);
                        }
                      },
                      child: Text('Fazer Login',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 20)),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => doSignup(context),
                      child: SizedBox(
                        width: size.width * 0.4,
                        child: PrimaryButtonWidget(
                            text: 'Criar',
                        ),
                      ),
                    )
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
