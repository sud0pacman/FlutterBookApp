part of 'audio_bloc.dart';

class AudioState {
  final bool back;
  final String openPdf;

  AudioState({required this.back, required this.openPdf});

  AudioState copyWith({
    bool? back,
    String? openPdf,
  }) =>
      AudioState(back: back ?? this.back, openPdf: openPdf ?? this.openPdf);
}
