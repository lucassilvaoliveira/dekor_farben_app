
import 'package:dekor_farben_app/blocs/recent_work/recent_work_event.dart';
import 'package:dekor_farben_app/blocs/recent_work/recent_work_state.dart';
import 'package:dekor_farben_app/core/entities/recent_work.dart';
import 'package:dekor_farben_app/core/usecases/recent_work/create_recent_work_use_case.dart';
import 'package:dekor_farben_app/core/usecases/recent_work/delete_recent_work_use_case.dart';
import 'package:dekor_farben_app/core/usecases/recent_work/get_recent_work_asset_use_case.dart';
import 'package:dekor_farben_app/core/usecases/recent_work/update_recent_work_use_case.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/recent_work_http_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentWorkBloc extends Bloc<RecentWorkEvent, RecentWorkState> {

  final getRecentWorkAssetUseCase
  = GetRecentWorkAssetUseCase(repository: RecentWorkHttpRepositoryImpl());

  final createRecentWorkUseCase = CreateRecentWorkUseCase(
      repository: RecentWorkHttpRepositoryImpl());

  final updateRecentWorkUseCase = UpdateRecentWorkUseCase(
      repository: RecentWorkHttpRepositoryImpl());

  final deleteRecentWorkUseCase = DeleteRecentWorkUseCase(
      repository: RecentWorkHttpRepositoryImpl());

  RecentWorkBloc() : super(RecentWorkInitState()) {
    on<CreateRecentWorkEvent>((event, emit) async {
      emit(RecentWorkLoadingState());

      final date = event.request.date;
      final image = event.request.image;

      final RecentWork recentWork = RecentWork(
          id: "",
          companyId: event.request.companyId,
          recentWorkName: "",
          recentWorkDescription: "",
          recentWorkDate: date,
          recentWorkPublication: "",
          recentWorkCreatedBy: "",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()
      );

      final result = await createRecentWorkUseCase.call(file: image, recentWork: recentWork);

      if (result.isSuccess()) {
        emit(RecentWorkCreateSuccessState());
      } else {
        emit(RecentWorkErrorState());
      }
    });
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
    on<UpdateRecentWorkEvent>((event, emit) async {
      emit(RecentWorkLoadingState());

      final aRecentWork = RecentWork(
          id: event.request.id,
          companyId: event.request.companyId,
          recentWorkName: "",
          recentWorkDescription: "",
          recentWorkDate: event.request.date,
          recentWorkPublication: "",
          recentWorkCreatedBy: "",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()
      );

      final result = await updateRecentWorkUseCase.call(recentWork: aRecentWork, file: event.request.image);

      if (result.isSuccess()) {
        emit(RecentWorkUpdateSuccessState());
      } else {
        emit(RecentWorkErrorState());
      }
    });
    on<DeleteRecentWorkEvent>((event, emit) async {
      emit(RecentWorkLoadingState());

      final result = await deleteRecentWorkUseCase.call(id: event.id);

      if (result.isSuccess()) {
        emit(RecentWorkDeleteSuccessState());
      } else {
        emit(RecentWorkErrorState());
      }
    });
  }
}
