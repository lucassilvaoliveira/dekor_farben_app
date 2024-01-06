import 'package:dekor_farben_app/blocs/user/user_state.dart';
import 'package:dekor_farben_app/core/usecases/user/create_user_use_case.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/user_http_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../company/company_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final createUserUseCase = CreateUserUseCase(repository: UserHttpRepositoryImpl());

  UserBloc() : super(UserGetInitialState()) {
    on<CreateUserEvent>((event, emit) async {
      final result = await createUserUseCase.call(user: event.user);

      if (result.isSuccess()) {
        emit(UserCreateSuccessState(userId: event.user.id));
      } else {
        emit(UserCreateOnErrorState(message: "Failed to create user"));
      }
    });
  }
}