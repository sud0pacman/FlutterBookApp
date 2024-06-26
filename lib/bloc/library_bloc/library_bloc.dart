import 'package:bloc/bloc.dart';
import 'package:book_store/bloc/home_bloc/home_bloc.dart';
import 'package:book_store/data/local/my_pref.dart';
import 'package:book_store/data/model/book_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'library_event.dart';

part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SharedPreferencesHelper _pref = SharedPreferencesHelper();

  LibraryBloc()
      : super(LibraryState(
            back: false,
            openHome: false,
            openSearch: false,
            openProfile: false,
            books: [])) {
    on<LibraryLoadBooks>(_onLoadBooks);
    on<LibraryBackEvent>(_onBack);
    on<LibraryHomeEvent>(_onHome);
  }

  _onHome(LibraryHomeEvent event, Emitter<LibraryState> emit) {
    emit(state.copyWith(openHome: true));
  }

  _onBack(LibraryBackEvent event, Emitter<LibraryState> emit) {
    emit(state.copyWith(back: true));
  }

  _onLoadBooks(LibraryLoadBooks event, Emitter<LibraryState> emit) async{
    print("***************************  library _onLoadBooks  ***************************");
    var snapshot = await _firestore.collection('books').get();

    List<BookData> books = snapshot.docs
        .map((doc) => BookData.fromMap(doc.id, doc.data()))
        .toList();

    List<BookData> res = [];

    for(var book in books) {
      var docId = _pref.getString(book.id);
      if(docId != null) {
        if(docId.isNotEmpty) {
          res.add(book);
        }
      }
    }

    print("**************************** library my size ${books.length} ****************************");

    emit(state.copyWith(books: res));
  }
}
