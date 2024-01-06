import 'package:dekor_farben_app/core/entities/company.dart';

abstract class CompanyState { }

class CompanyGetInitialState extends CompanyState {}
class CompanyGetLoadingState extends CompanyState {}
class CompanyGetSuccessState extends CompanyState {
  final List<Company> companies;

  CompanyGetSuccessState(this.companies);
}

class CompanyGetOneSuccessState extends CompanyState {
  final Company company;

  CompanyGetOneSuccessState.initial() : company = Company(
      id: "",
      companyName: "",
      companyPassword: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      campaigns: List.empty(),
      recentWorks: List.empty()
  );

  CompanyGetOneSuccessState({required this.company});
}

class CompanyCreateInitialState extends CompanyState { }
class CompanyCreateLoadingState extends CompanyState { }
class CompanyCreateSuccessState extends CompanyState { }
class CompanyAlreadyRegisteredState extends CompanyState { }
class CompanyCreateOnErrorState extends CompanyState {
  final String message;

  CompanyCreateOnErrorState({required this.message});
}

class CompanyGetOnErrorState extends CompanyState {
  final String message;

  CompanyGetOnErrorState({required this.message});
}