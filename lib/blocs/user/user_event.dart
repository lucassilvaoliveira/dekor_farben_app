import 'package:dekor_farben_app/core/entities/company.dart';

abstract class CompanyEvent {}

class CreateCompanyEvent extends CompanyEvent {
  Company company;

  CreateCompanyEvent({
    required this.company,
  });
}

class GetAllCompanyEvent extends CompanyEvent { }