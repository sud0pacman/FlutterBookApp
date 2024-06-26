part of 'audio_bloc.dart';


abstract class AudioEvent {}

class BackEvent extends AudioEvent {}

class OpenPDFEvent extends AudioEvent {
  final String pdfUrl;

  OpenPDFEvent({required this.pdfUrl});
}
