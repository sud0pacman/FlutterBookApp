import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/book_data.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  HomeBloc() : super(HomeState(books: [])) {
    on<LoadBooksEvent>(_onLoadBooks);
  }

  Future<void> _onLoadBooks(LoadBooksEvent event, Emitter<HomeState> emit) async {
    print("***************************  _onLoadBooks  ***************************");
    var snapshot = await _firestore.collection('books').get();

    List<BookData> books = snapshot.docs
        .map((doc) => BookData.fromMap(doc.data()))
        .toList();

    print("**************************** my size ${books.length} ****************************");

    emit(state.copyWith(books: books));
  }
}
