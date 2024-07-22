import 'package:dio/dio.dart';

Future<List<String>> fetchAdditionalImages(String query) async {
  final dio = Dio();
  final response = await dio.get(
    'https://www.googleapis.com/books/v1/volumes',
    queryParameters: {
      'q': query,
      'filter': 'free-ebooks',
      'orderBy': 'relevance',
    },
  );

  if (response.statusCode == 200) {
    final List books = response.data['items'];
    return books
        .map((book) => book['volumeInfo']['imageLinks']['thumbnail'] as String)
        .toList();
  } else {
    throw Exception('Failed to load images');
  }
}
