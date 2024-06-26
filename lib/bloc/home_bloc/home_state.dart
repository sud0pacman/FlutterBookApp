part of 'home_bloc.dart';


class HomeState {
  final List<BookData> books;

  HomeState({required this.books});

  HomeState copyWith({List<BookData>? books}) {
    return HomeState(
      books: books ?? this.books,
    );
  }
}