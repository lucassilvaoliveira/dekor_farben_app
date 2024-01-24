import 'package:dekor_farben_app/blocs/company/company_event.dart';
import 'package:dekor_farben_app/core/entities/company.dart';

abstract class CompanyEvent {}

class CreateCompanyEvent extends CompanyEvent {
  Company company;

  CreateCompanyEvent({
    required this.company,
  });
}

class GetAllCompanyEvent extends CompanyEvent { }

class GetOneUserEvent extends UserEvent {
  final String userId;

  GetOneUserEvent({required this.userId});
}