part of 'home_bloc.dart';

abstract class HomeEvent {}

class LoadBooksEvent extends HomeEvent {}
class OpenBookEvent extends HomeEvent {}
class BackEvent extends HomeEvent {}
class SelectCategoryEvent extends HomeEvent {}