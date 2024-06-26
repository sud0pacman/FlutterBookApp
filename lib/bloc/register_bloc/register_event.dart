part of 'register_bloc.dart';

abstract class RegisterEvent {}

class ClickRegisterEvent extends RegisterEvent {
  final String mail;
  final String password;

  ClickRegisterEvent({required this.mail, required this.password});
}

class RegisterWithGoogleEvent extends RegisterEvent {}
class RegisterWithFacebookEvent extends RegisterEvent {}
class SignInEvent extends RegisterEvent {}