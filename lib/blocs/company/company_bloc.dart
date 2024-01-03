import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/usecases/company/get_company_use_case.dart';
import '../../infrastructure/implementations/http/company_http_repository_impl.dart';
import '../user/user_event.dart';
import 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final getCompanyUseCase = GetCompanyUseCase(
      repository: CompanyHttpRepositoryImpl());

  CompanyBloc() : super(CompanyGetInitialState()) {
    on<GetAllCompanyEvent>((event, emit) async {
      final result = await getCompanyUseCase.call();

      if (result.isSuccess()) {
        emit(CompanyGetSuccessState(result.tryGetSuccess()!));
      } else {
        print(result.tryGetError()!.cause);
        emit(CompanyGetOnErrorState(message: result.tryGetError()!.cause));
      }
    });
  }
}