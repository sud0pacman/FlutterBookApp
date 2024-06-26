part of 'library_bloc.dart';


class LibraryState {
  final bool back;
  final bool openHome;
  final bool openSearch;
  final bool openProfile;
  final List<BookData> books;

  LibraryState({
    required this.back,
    required this.openHome,
    required this.openSearch,
    required this.openProfile,
    required this.books,
  });

  LibraryState copyWith({
    bool? back,
    bool? openHome,
    bool? openSearch,
    bool? openProfile,
    List<BookData>? books,
  }) {
    return LibraryState(
      back: back ?? this.back,
      openHome: openHome ?? this.openHome,
      openSearch: openSearch ?? this.openSearch,
      openProfile: openProfile ?? this.openProfile,
      books: books ?? this.books,
    );
  }
}
