import 'package:book_app/features/search/data/model/search_model.dart';
import 'package:dio/dio.dart';

class SearchService {
  final Dio _dio = Dio();

  Future<List<Book>> searchBooks(String query) async {
    final response = await _dio.get(
      'https://www.googleapis.com/books/v1/volumes',
      queryParameters: {'q': query},
    );

    if (response.statusCode == 200) {
      return (response.data['items'] as List<dynamic>)
          .map((item) => Book.fromJson(item['volumeInfo']))
          .toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
