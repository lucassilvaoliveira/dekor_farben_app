import 'dart:io';

class CreteRecentWorkRequest {
  final DateTime date;
  final File image;
  final String companyId;

  CreteRecentWorkRequest({required this.date, required this.image, required this.companyId});
}