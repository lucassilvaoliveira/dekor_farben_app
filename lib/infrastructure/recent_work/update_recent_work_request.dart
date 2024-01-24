import 'dart:io';

class UpdateRecentWorkRequest {
  final String id;
  final DateTime date;
  final File image;
  final String companyId;

  UpdateRecentWorkRequest({required this.id, required this.date, required this.image, required this.companyId});
}