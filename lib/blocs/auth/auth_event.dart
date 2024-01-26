import '../../infrastructure/auth/auth_request.dart';

abstract class AuthEvent {}

class OnAuthEvent extends AuthEvent {
  final AuthRequest aRequest;

  OnAuthEvent({required this.aRequest});
}