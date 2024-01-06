
import 'package:dekor_farben_app/core/entities/recent_work.dart';

abstract class RecentWorkState { }

class RecentWorkInitState extends RecentWorkState { }
class RecentWorkLoadingState extends RecentWorkState { }

class RecentWorkGetAssetsSuccessState extends RecentWorkState {
  final List<RecentWork> recentWorks;

  RecentWorkGetAssetsSuccessState({required this.recentWorks});
}

class RecentWorkGetAssetErrorState extends RecentWorkState {
  final String errorMessage;

  RecentWorkGetAssetErrorState({required this.errorMessage});
}