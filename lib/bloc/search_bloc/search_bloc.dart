import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/model/book_data.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SearchBloc() : super(SearchState(isBack: false, searched: [])) {
    on<Search>(_onSearch);
  }

  _onSearch(Search event, Emitter<SearchState> emit) async {
    if(event.inputKey.isEmpty) return;
    List<BookData> books = await _getBooks();
    List<BookData> res = [];

    for(var book in books) {
      if(book.bookName.toLowerCase().startsWith(event.inputKey.toLowerCase())) {
        res.add(book);
      }
    }

    print("********************* searched ${res.length}");

    emit(state.copyWith(search: res));
  }

  Future<List<BookData>> _getBooks() async {
    var snapshot = await _firestore
        .collection('books')
        .get();

    return snapshot.docs
        .map((doc) => BookData.fromMap(doc.id, doc.data()))
        .toList();
  }
}
