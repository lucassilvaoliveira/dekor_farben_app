import 'package:dekor_farben_app/core/entities/recent_work.dart';
import 'package:dekor_farben_app/infrastructure/recent_work/update_recent_work_request.dart';

import '../../infrastructure/recent_work/create_recent_work_request.dart';

abstract class RecentWorkEvent {}

class GetRecentWorkAssetsEvent extends RecentWorkEvent {
  final List<RecentWork> recentWorks;

  GetRecentWorkAssetsEvent({required this.recentWorks});
}

class CreateRecentWorkEvent extends RecentWorkEvent {
  final CreteRecentWorkRequest request;

  CreateRecentWorkEvent({required this.request});
}

class UpdateRecentWorkEvent extends RecentWorkEvent {
  final UpdateRecentWorkRequest request;

  UpdateRecentWorkEvent({required this.request});
}

class DeleteRecentWorkEvent extends RecentWorkEvent {
  final String id;

  DeleteRecentWorkEvent({required this.id});
}