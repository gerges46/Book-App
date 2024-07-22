class Book {
  final String title;
  final List<String> authors;
  final String thumbnail;
  final String smallThumbnail;
  final double price;
  final double rating;

  Book({
    required this.title,
    required this.authors,
    required this.thumbnail,
    required this.smallThumbnail,
    required this.price,
    required this.rating,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];
    final saleInfo = json['saleInfo'];

    return Book(
      title: volumeInfo['title'] ?? 'No title',
      authors: List<String>.from(volumeInfo['authors'] ?? []),
      thumbnail: volumeInfo['imageLinks']?['thumbnail'] ?? '',
      smallThumbnail: volumeInfo['imageLinks']?['smallThumbnail'] ?? '',
      price: saleInfo['listPrice'] != null
          ? saleInfo['listPrice']['amount'].toDouble()
          : 0.0,
      rating: volumeInfo['averageRating'] != null
          ? volumeInfo['averageRating'].toDouble()
          : 0.0,
    );
  }
}
