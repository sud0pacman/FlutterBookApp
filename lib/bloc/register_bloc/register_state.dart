part of 'register_bloc.dart';

class RegisterState {
  final bool back;
  final bool registered;
  final bool openGoogleRegister;
  final bool openFacebookRegister;
  final bool signIn;
  final String toast;

  RegisterState(
      {required this.back,
      required this.registered,
      required this.openGoogleRegister,
      required this.openFacebookRegister,
      required this.signIn,
      required this.toast});

  RegisterState copyWith(
          {bool? back,
          bool? registered,
          bool? openGoogleRegister,
          bool? openFacebookRegister,
          bool? signIn,
          String? toast}) =>
      RegisterState(
          back: back ?? this.back,
          registered: registered ?? this.registered,
          openGoogleRegister: openGoogleRegister ?? this.openGoogleRegister,
          openFacebookRegister: openFacebookRegister ?? this.openFacebookRegister,
          signIn: signIn ?? this.signIn,
          toast: toast ?? this.toast);
}
