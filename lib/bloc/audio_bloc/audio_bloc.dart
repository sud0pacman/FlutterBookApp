import 'package:bloc/bloc.dart';

part 'audio_event.dart';

part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc() : super(AudioState(back: false, openPdf: "")) {
    on<BackEvent>(_onBackEvent);
    on<OpenPDFEvent>(_onOpenPdf);
  }

  _onOpenPdf(OpenPDFEvent event, Emitter<AudioState> emit) {
    emit(state.copyWith(openPdf: event.pdfUrl));
  }

  _onBackEvent(BackEvent event, Emitter<AudioState> emit) {
    emit(state.copyWith(back: true));
  }
}
