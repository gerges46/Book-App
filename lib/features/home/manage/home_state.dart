import 'package:book_app/features/home/data/model/book_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Book> books;

  HomeLoaded(this.books);
}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}