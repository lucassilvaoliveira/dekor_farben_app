import 'package:dekor_farben_app/blocs/auth/auth_event.dart';
import 'package:dekor_farben_app/blocs/auth/auth_state.dart';
import 'package:dekor_farben_app/core/usecases/auth/auth_use_case.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/auth_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final authUseCase = AuthUseCase(repository: AuthRepositoryImpl());

  AuthBloc() : super(AuthInitialState()) {
    on<OnAuthEvent>((event, emit) async {
      emit(AuthLoadingState());

      final anEmail = event.aRequest.email;
      final aPassword = event.aRequest.password;

      final result = await authUseCase.call(
          email: anEmail,
          password: aPassword
      );

      if (result.isSuccess()) {
        emit(AuthSuccessState());
      } else {
        emit(AuthFailureState());
      }
    });
  }
}