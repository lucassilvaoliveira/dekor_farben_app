import 'package:dekor_farben_app/core/entities/user.dart';

abstract class UserEvent {}

class CreateUserEvent extends UserEvent {
  User user;

  CreateUserEvent({
    required this.user,
  });
}