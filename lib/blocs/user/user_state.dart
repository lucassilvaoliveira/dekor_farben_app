import '../../core/entities/user.dart';

abstract class UserState { }

class UserGetInitialState extends UserState {}
class UserGetLoadingState extends UserState {}
class UserGetSuccessState extends UserState {
  final List<User> users;

  UserGetSuccessState(this.users);
}

class UserGetOneSuccessState extends UserState {
  final User user;

  UserGetOneSuccessState({required this.user});

  UserGetOneSuccessState.initial() : user = User(
      id: "",
      userType: "",
      userEmail: "",
      userPassword: "",
      userName: "",
      telephoneNumber: "",
      userBirthday: DateTime.now(),
      userDocument: "",
      userPoints: 0,
      userAvatarPath: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now()
  );
}

class UserCreateInitialState extends UserState { }
class UserCreateLoadingState extends UserState { }

class UserCreateSuccessState extends UserState {
  final String userId;

  UserCreateSuccessState({required this.userId});
}

class UserAlreadyRegisteredState extends UserState { }
class UserCreateOnErrorState extends UserState {
  final String message;

  UserCreateOnErrorState({required this.message});
}