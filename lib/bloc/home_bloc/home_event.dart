part of 'home_bloc.dart';

abstract class HomeEvent {}

class LoadBooksEvent extends HomeEvent {}

class OpenBookEvent extends HomeEvent {}

class BackEvent extends HomeEvent {}

class SelectCategoryEvent extends HomeEvent {}

class OpenLibrary extends HomeEvent {}

class HomeFilterEvent extends HomeEvent {
  final String category;

  HomeFilterEvent({required this.category});
}

class HomeSearchScreenEvent extends HomeEvent {}