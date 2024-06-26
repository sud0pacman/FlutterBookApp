import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/local/my_pref.dart';
import '../../ui/theme/constant_keys.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SharedPreferencesHelper _pref = SharedPreferencesHelper();
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

      // _pref.setString(ConstantKeys.mail, event.mail);

      emit(state.copyWith(signed: true, toast: "Successfully signed"));
    } catch (e) {
      emit(state.copyWith(toast: "Failed: ${e}"));
    }
  }
}
