import 'package:dekor_farben_app/core/entities/recent_work.dart';

abstract class RecentWorkEvent {}

class GetRecentWorkAssetsEvent extends RecentWorkEvent {
  final List<RecentWork> recentWorks;

  GetRecentWorkAssetsEvent({required this.recentWorks});
}