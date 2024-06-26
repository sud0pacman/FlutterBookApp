part of 'search_bloc.dart';

abstract class SearchEvent {}

class Search extends SearchEvent {
  final String inputKey;

  Search({required this.inputKey});
}

class SearchBackEvent extends SearchEvent {}