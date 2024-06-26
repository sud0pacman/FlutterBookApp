part of 'sign_in_bloc.dart';


class SignInState {
  final bool back;
  final bool signed;
  final bool openGoogleSigner;
  final bool openFacebookSigner;
  final bool signUp;
  final String toast;

  SignInState(
      {required this.back,
        required this.signed,
        required this.openGoogleSigner,
        required this.openFacebookSigner,
        required this.signUp,
        required this.toast});

  SignInState copyWith(
      {bool? back,
        bool? signed,
        bool? openGoogleSigner,
        bool? openFacebookSigner,
        bool? signUp,
        String? toast}) =>
      SignInState(
          back: back ?? this.back,
          signed: signed ?? this.signed,
          openGoogleSigner: openGoogleSigner ?? this.openGoogleSigner,
          openFacebookSigner: openFacebookSigner ?? this.openFacebookSigner,
          signUp: signUp ?? this.signUp,
          toast: toast ?? this.toast);
}
