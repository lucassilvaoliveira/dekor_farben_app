import 'package:dekor_farben_app/blocs/company/company_state.dart';
import 'package:dekor_farben_app/blocs/user/user_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/company/company_bloc.dart';
import '../../../../core/entities/company.dart';
import '../../../../global/constants.dart';
import '../../../home_screen/home_screeen.dart';

class ChooseCompanyBody extends StatefulWidget {
  const ChooseCompanyBody({super.key});

  @override
  State<ChooseCompanyBody> createState() => _ChooseCompanyBodyState();
}

class _ChooseCompanyBodyState extends State<ChooseCompanyBody> {
  List<Company> filteredCompanies = [];
  List<Company> companies = [];

  void updateList(String value) {
    String searchQuery = value.toLowerCase();


    setState(() {
      filteredCompanies = companies.where((company) {
        return company.companyName.toLowerCase().contains(searchQuery);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CompanyBloc>(context).add(GetAllCompanyEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<CompanyBloc, CompanyState>(
        listener: (context, state) {
          if (state is CompanyGetSuccessState) {
            setState(() {
              companies = state.companies;
              filteredCompanies = companies;
            });
          }
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: kDefaultPrimaryColor,
                  height: 200,
                  width: size.width,
                  child: Center(
                    child: Container(
                      width: size.width,
                      margin: const EdgeInsets.only(left: 25, top: 50),
                      child: Text(
                        'Selecione a empresa\nque deseja ver hoje',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset:
                              const Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(top: 155),
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (value) => updateList(value),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Pesquisar empresa',
                          prefixIcon: const Icon(Icons.search)),
                    )),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding * 2, vertical: 5),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * .65,
                        width: size.width,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 0),
                          itemCount: filteredCompanies.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => const HomeScreen()),
                                  (route) => false);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              width: size.width,
                              child: Column(
                                children: [
                                  Image.memory(
                                    filteredCompanies[index].image!,
                                    width: size.width * .25,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(filteredCompanies[index].companyName),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 1,
                                    width: size.width,
                                    color: Colors.black.withOpacity(.3),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

List<Map<String, dynamic>> settingsOptionsData = [
  {
    "name": "Decor Colors - Blumenau Centro",
    "icon": "assets/images/decor-colors-logo.png",
  },
  {
    "name": "Spotify",
    "icon": "assets/images/spotify-logo.png",
  },
  {
    "name": "Github",
    "icon": "assets/images/github-logo.png",
  },
  {
    "name": "Airbnb",
    "icon": "assets/images/airbnb-logo.png",
  },
];
