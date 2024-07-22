import 'package:book_app/features/home/data/repo/api_service.dart';
import 'package:book_app/features/home/manage/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final BookService bookService;

  HomeCubit(this.bookService) : super(HomeInitial());

  void fetchBooks() async {
    emit(HomeLoading());
    try {
      final books = await bookService.fetchBooks();
      emit(HomeLoaded(books));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}