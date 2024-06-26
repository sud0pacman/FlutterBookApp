part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class ClickSignInEvent extends SignInEvent {
  final String mail;
  final String password;

  ClickSignInEvent({required this.mail, required this.password});
}

class RegisterWithGoogleEvent extends SignInEvent {}
class RegisterWithFacebookEvent extends SignInEvent {}
class SignUpEvent extends SignInEvent {}
