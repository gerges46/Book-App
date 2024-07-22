import 'package:book_app/features/details/details_screen.dart';
import 'package:book_app/features/home/data/model/book_model.dart';

import 'package:book_app/features/search/screens/search_screen.dart';

import 'package:go_router/go_router.dart';
import 'package:book_app/features/home/screens/home_screen.dart';
import 'package:book_app/features/splash/screens/splash_screen.dart';

class AppRouter {
  static const name = "/";
  static const home = "/homeScreen";
  static const details = "/detailsScreen";
  static const search = "/searchScreen";

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: details,
        builder: (context, state) {
          final book = state.extra as Book;
          return BookDetailScreen(book: book);
        },
      ),
      GoRoute(
        path: '/searchScreen',
        builder: (context, state) {
          final query = state.extra as String?;
          return SearchScreen(initialQuery: query ?? '');
        },
      ),
    ],
  );
}
