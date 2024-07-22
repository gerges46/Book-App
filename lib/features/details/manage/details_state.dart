
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdditionalImagesCubit extends Cubit<List<String>> {
  final Dio dio;

  AdditionalImagesCubit(this.dio) : super([]);

  Future<void> fetchAdditionalImages(String query) async {
    try {
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
        final images = books
            .map((book) => book['volumeInfo']['imageLinks']['thumbnail'] as String)
            .toList();
        emit(images);
      } else {
        emit([]);
      }
    } catch (e) {
      emit([]);
      print('Error: $e');
    }
  }
}
