part of 'home_bloc.dart';

class HomeState {
  final List<BookData> books;
  final bool back;
  final bool openLibrary;
  final Set<String> categories;
  final bool openSearch;

  HomeState(
      {required this.books,
      required this.back,
      required this.openLibrary,
      required this.categories,
      required this.openSearch});

  HomeState copyWith(
      {List<BookData>? books,
      bool? back,
      bool? openLibrary,
      Set<String>? categories,
      bool? openSearch}) {
    return HomeState(
        books: books ?? this.books,
        back: back ?? this.back,
        openLibrary: openLibrary ?? this.openLibrary,
        categories: categories ?? this.categories,
        openSearch: openLibrary ?? this.openSearch
    );
  }

  @override
  String toString() {
    return 'HomeState{books: ${books.length}, back: $back, openLibrary: $openLibrary, categories: ${categories.length}, openSearch: ${openSearch}}';
  }
}
