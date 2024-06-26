part of 'profile_bloc.dart';


class ProfileState {
  final String mail;

  ProfileState({required this.mail});

  ProfileState copyWith({
    String? mail,
  }) {
    return ProfileState(
      mail: mail ?? this.mail,
    );
  }
}