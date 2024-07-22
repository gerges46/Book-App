import 'package:book_app/constants/app_string.dart';
import 'package:book_app/features/home/data/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class HomeBookWidget extends StatelessWidget {
  const HomeBookWidget({super.key, required this.books});

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    final booksForSale = books.where((book) => book.price > 0).toList();

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return GestureDetector(
                onTap: () {
                  context.push('/detailsScreen', extra: book);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: CachedNetworkImage(
                        imageUrl: book.thumbnail,
                        height: 180,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              AppString.bestSeller,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
     
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: booksForSale.length,
            itemBuilder: (context, index) {
              final book = booksForSale[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  leading: book.thumbnail.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: SizedBox(
                            width: 60,
                            height: 60,
                            child: CachedNetworkImage(
                              imageUrl: book.thumbnail,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        )
                      : null,
                  title: Text(book.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.authors.join(', ')),
                      Row(
                        children: [
                          Text('Price: \$${book.price.toStringAsFixed(2)}'),
                          SizedBox(width: 16),
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          SizedBox(width: 4),
                          Text(book.rating.toString()),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    context.push('/detailsScreen', extra: book);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
