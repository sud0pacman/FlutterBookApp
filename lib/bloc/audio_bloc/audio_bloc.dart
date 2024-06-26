import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc() : super(AudioInitial()) {
    on<AudioEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
