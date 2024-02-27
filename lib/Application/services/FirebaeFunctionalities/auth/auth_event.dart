part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}
class AuthCheckRequested extends AuthEvent {
  @override
  List<Object?> get props => [];
}


class SignupRequested extends AuthEvent{
  String email;
  String pass;
  final BuildContext context;


  SignupRequested({required this.email, required this.pass,required this.context});
}

class CheckEmailEvent extends AuthEvent {
  String email;

  CheckEmailEvent({required this.email});

}
class CheckPassEvent extends AuthEvent {
  String Password;

  CheckPassEvent({required this.Password});
}

class SignOutRequested extends AuthEvent {
  final BuildContext context;

  SignOutRequested(this.context);

  @override
  List<Object?> get props => [];
}
