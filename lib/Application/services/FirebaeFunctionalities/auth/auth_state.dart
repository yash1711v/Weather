part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  final MyUser? user;

  AuthSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class Emailtextchangestate extends AuthState{
  String email;

  Emailtextchangestate(this.email);
}

class PasswordtextChangestate extends AuthState{
  String pass;

  PasswordtextChangestate(this.pass);
}

class WrongEmailState extends AuthState {
  String error;
  WrongEmailState({required this.error});
}

class WrongPassState extends AuthState {
  String error;
  WrongPassState({required this.error});
}


class AuthLoadingState extends AuthState {}
