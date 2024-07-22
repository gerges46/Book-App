import 'package:book_app/features/search/manage/search_cubit.dart';
import 'package:book_app/features/search/manage/search_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatelessWidget {
  final String initialQuery;

  const SearchScreen({Key? key, required this.initialQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller =
        TextEditingController(text: initialQuery);
    final SearchCubit _searchCubit = SearchCubit(Dio())
      ..searchBooks(initialQuery);

    void _onSearch() {
      final query = _controller.text.trim();

      if (query.isNotEmpty) {
        _searchCubit.searchBooks(query);
      }

      if (query.isNotEmpty) {
        _searchCubit.searchBooks(query);
      }
    }

    return BlocProvider(
        create: (context) => _searchCubit,
        child: Scaffold(
          appBar: AppBar(
            title: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.white, width: 0.8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 0.8,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _onSearch,
                ),
              ),
              onFieldSubmitted: (value) => _onSearch(),
            ),
          ),
          body: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SearchLoaded) {
                final book = state.books.first;
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.authors.join(', ')),
                  onTap: () {
                    context.push('/detailsScreen', extra: book);
                  },
                );
              } else if (state is SearchError) {
                return Center(child: Text(state.error));
              } else {
                return Center(child: Text('No results found'));
              }
            },
          ),
        ));
  }
}
