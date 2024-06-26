import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/book_data.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  HomeBloc() : super(HomeState(books: [], back: false, openLibrary: false, categories: {}, openSearch: false)) {
    on<LoadBooksEvent>(_onLoadBooks);
    on<BackEvent>(_onBack);
    on<OpenLibrary>(_onOpenLibrary);
    on<HomeFilterEvent>(_onFilter);
    on<HomeSearchScreenEvent>(_onOpenSearch);
  }

  _onOpenSearch(HomeSearchScreenEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(openSearch: true, openLibrary: false));
  }


  Future<void> _onOpenLibrary(OpenLibrary event, Emitter<HomeState> emit) async {
    emit(state.copyWith(openLibrary: true, openSearch: false));
  }

  Future<void> _onFilter(HomeFilterEvent event, Emitter<HomeState> emit) async {
    List<BookData> books = await _getBooks();

    Set<String> categories = {};
    categories.add("all");
    for(var book in books) {
      categories.add(book.category);
    }

    if(event.category == "all") {
      emit(state.copyWith(books: books, categories: categories));
    }
    else {
      List<BookData> filteredBooks = books.where((book) => book.category == event.category).toList();
      emit(state.copyWith(books: filteredBooks, categories: categories));
    }
  }


  Future<void> _onBack(BackEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(back: true, openSearch: false, openLibrary: false));
  }

  Future<void> _onLoadBooks(LoadBooksEvent event, Emitter<HomeState> emit) async {
    print("***************************  _onLoadBooks  ***************************");
    List<BookData> books = await _getBooks();

    Set<String> categories = {};
    categories.add("all");
    for(var book in books) {
      categories.add(book.category);
    }

    emit(state.copyWith(books: books, categories: categories));
  }

  Future<List<BookData>> _getBooks() async{
    var snapshot = await _firestore.collection('books').get();
    return snapshot.docs
        .map((doc) => BookData.fromMap(doc.id, doc.data()))
        .toList();
  }
}