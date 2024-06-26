import 'package:bloc/bloc.dart';
import 'package:book_store/data/local/my_pref.dart';
import 'package:book_store/ui/theme/constant_keys.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SharedPreferencesHelper _pref = SharedPreferencesHelper();
  ProfileBloc() : super(ProfileState(mail: "")) {
    on<ProfileEvent>((event, emit) {
      emit(state.copyWith(mail: _pref.getString(ConstantKeys.mail)));
    });
  }
}
