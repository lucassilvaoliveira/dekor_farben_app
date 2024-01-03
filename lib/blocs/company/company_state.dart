import 'package:dekor_farben_app/core/entities/company.dart';

import '../../core/entities/user.dart';

abstract class CompanyState { }

class CompanyGetInitialState extends CompanyState {}
class CompanyGetLoadingState extends CompanyState {}
class CompanyGetSuccessState extends CompanyState {
  final List<Company> companies;

  CompanyGetSuccessState(this.companies);
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