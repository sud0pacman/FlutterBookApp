part of 'library_bloc.dart';


abstract class LibraryEvent{}

class LibraryBackEvent extends LibraryEvent {}
class LibraryHomeEvent extends LibraryEvent {}
class LibraryLoadBooks extends LibraryEvent {}