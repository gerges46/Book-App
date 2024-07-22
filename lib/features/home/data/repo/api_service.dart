import 'package:book_app/features/home/data/model/book_model.dart';
import 'package:dio/dio.dart';

class BookService {
  static const String _baseUrl =
      'https://www.googleapis.com/books/v1/volumes?q=flutter';

  final Dio _dio = Dio();

  Future<List<Book>> fetchBooks() async {
    final response = await _dio.get(_baseUrl);

    if (response.statusCode == 200) {
      final data = response.data;
      final List<dynamic> items = data['items'];
      return items.map((item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Book>> searchBooks(String query) async {
    final Dio dio = Dio();

    final response = await dio.get(
      'https://www.googleapis.com/books/v1/volumes',
      queryParameters: {
        'q': query,
      },
    );

    if (response.statusCode == 200) {
      final List booksJson = response.data['items'];
      return booksJson.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
