import 'package:book_app/constants/app_string.dart';

import 'package:book_app/features/home/manage/home_cubit.dart';
import 'package:book_app/features/home/manage/home_state.dart';

import 'package:book_app/features/home/data/repo/api_service.dart';
import 'package:book_app/features/home/widgets/home_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppString.book),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                context.push('/searchScreen');
              },
              icon: Icon(Icons.search, size: 30),
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => HomeCubit(BookService())..fetchBooks(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is HomeLoaded) {
              final books = state.books;
              if (books.isEmpty) {
                return Center(child: Text('No books found'));
              } else {
                return HomeBookWidget(books: books);
              }
            } else {
              return Center(child: Text('No books found'));
            }
          },
        ),
      ),
    );
  }
}
