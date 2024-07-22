import 'package:book_app/features/details/manage/detials_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_app/features/home/data/model/book_model.dart';
import 'package:book_app/features/home/data/repo/api_service.dart';
import 'package:book_app/features/details/details_screen.dart';

class BookListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookCubit(BookService())..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Books'),
        ),
        body: BlocBuilder<BookCubit, List<Book>>(
          builder: (context, books) {
            if (books.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  leading: book.thumbnail.isNotEmpty
                      ? Image.network(book.thumbnail)
                      : Icon(Icons.book),
                  title: Text(book.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(book: book),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
