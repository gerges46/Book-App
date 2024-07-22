import 'package:book_app/features/home/data/model/book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BestSaller extends StatelessWidget {
  BestSaller({super.key, required this.books, });
  
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    final booksForSale = books.where((book) => book.price > 0).toList();
    return Column(
      children: [
    /*        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
           'bestsaller',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ), */
        // List of books for sale
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
                          borderRadius: BorderRadius.circular(12.0), // Set border radius
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
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(book.rating.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    )
      
    ;
  }
}