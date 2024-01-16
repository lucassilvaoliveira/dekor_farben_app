
import 'package:dekor_farben_app/blocs/recent_work/recent_work_event.dart';
import 'package:dekor_farben_app/blocs/recent_work/recent_work_state.dart';
import 'package:dekor_farben_app/core/usecases/recent_work/get_recent_work_asset_use_case.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/recent_work_http_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentWorkBloc extends Bloc<RecentWorkEvent, RecentWorkState> {

  final getRecentWorkAssetUseCase
  = GetRecentWorkAssetUseCase(repository: RecentWorkHttpRepositoryImpl());

  RecentWorkBloc() : super(RecentWorkInitState()) {
    on<GetRecentWorkAssetsEvent>((event, emit) async {
      emit(RecentWorkLoadingState());

      final result
      = await getRecentWorkAssetUseCase.call(recentWorks: event.recentWorks);

      if (result.isSuccess()) {
        emit(RecentWorkGetAssetsSuccessState(recentWorks: event.recentWorks));
      } else {
        emit(RecentWorkGetAssetErrorState(errorMessage: "Failed to load asset"));
      }
    });
  }
}
