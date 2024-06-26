import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc()
      : super(SignInState(
            back: false,
            signed: false,
            openGoogleSigner: false,
            openFacebookSigner: false,
            signUp: false,
            toast: "")) {
    on<ClickSignInEvent>(_onClickSignIn);
    on<SignUpEvent>(_onSignUp);
  }

  _onSignUp(SignUpEvent event, Emitter<SignInState> emit) async{
    emit(state.copyWith(signUp: true));
  }

  _onClickSignIn(ClickSignInEvent event, Emitter<SignInState> emit) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.mail,
        password: event.password,
      );

      emit(state.copyWith(signed: true, toast: "Successfully signed"));
    } catch (e) {
      emit(state.copyWith(toast: "Failed: ${e}"));
    }
  }
}
