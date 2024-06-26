part of 'search_bloc.dart';

class SearchState {
  final bool isBack;
  final List<BookData> searched;

  SearchState({
    required this.isBack,
    required this.searched,
  });

  SearchState copyWith({
    bool? isBack,
    List<BookData>? search,
  }) {
    return SearchState(
      isBack: isBack ?? this.isBack,
      searched: search ?? this.searched,
    );
  }
}