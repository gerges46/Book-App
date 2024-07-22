import 'package:book_app/features/home/data/model/book_model.dart';

import 'package:book_app/features/search/manage/search_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final Dio dio;

  SearchCubit(this.dio) : super(SearchInitial());

  Future<void> searchBooks(String query) async {
    emit(SearchLoading());
    try {
      final response = await dio
          .get('https://www.googleapis.com/books/v1/volumes?q=intitle:$query');
      final books = (response.data['items'] as List)
          .map((item) => Book.fromJson(item))
          .toList();
      final exactMatches = books
          .where((book) => book.title.toLowerCase() == query.toLowerCase())
          .toList();
      if (exactMatches.isEmpty) {
        emit(SearchError('Not found'));
      } else {
        emit(SearchLoaded(exactMatches));
      }
    } catch (e) {
      emit(SearchError('Error: ${e.toString()}'));
    }
  }
}
