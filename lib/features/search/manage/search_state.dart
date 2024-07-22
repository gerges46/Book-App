import 'package:book_app/features/home/data/model/book_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Book> books;

  SearchLoaded(this.books);
}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}
