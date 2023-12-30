import '../core/entities/user.dart';

abstract class UserState { }

class UserGetInitialState extends UserState {}
class UserGetLoadingState extends UserState {}
class UserGetSuccessState extends UserState {
  final List<User> users;

  UserGetSuccessState(this.users);
}

class UserCreateInitialState extends UserState { }
class UserCreateLoadingState extends UserState { }
class UserCreateSuccessState extends UserState { }
class UserCreateOnErrorState extends UserState {
  final String message;

  UserCreateOnErrorState({required this.message});
}