import 'package:bloc/bloc.dart';
import 'package:book_store/ui/theme/constant_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/local/my_pref.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SharedPreferencesHelper _pref = SharedPreferencesHelper();
  RegisterBloc()
      : super(RegisterState(
            back: false,
            registered: false,
            openGoogleRegister: false,
            openFacebookRegister: false,
            signIn: false, toast: '')) {
    on<ClickRegisterEvent>(_onRegister);
    on<SignInEvent>(_onSignIn);
  }

  _onSignIn(SignInEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(signIn: true));
  }

  _onRegister(ClickRegisterEvent event, Emitter<RegisterState> emit) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.mail,
        password: event.password,
      );

      _pref.setString(ConstantKeys.registerStatus, "1");

      emit(state.copyWith(registered: true, toast: "Success"));
    } catch (e) {
      emit(state.copyWith(toast: "Registration failed ${e}"));
    }
  }
}
