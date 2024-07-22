
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_app/features/home/data/model/book_model.dart';
import 'package:book_app/features/home/data/repo/api_service.dart';

class BookCubit extends Cubit<List<Book>> {
  final BookService bookService;

  BookCubit(this.bookService) : super([]);

  Future<void> fetchBooks() async {
    try {
      final books = await bookService.fetchBooks();
      emit(books);
    } catch (e) {
      emit([]);
      print('Error: $e');
    }
  }
}
