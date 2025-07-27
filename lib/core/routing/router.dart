import 'package:go_router/go_router.dart';
import '../../features/movies/presentation/pages/popular_movies_page.dart';
import '../../features/movies/presentation/pages/search_movies_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => PopularMoviesPage(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => SearchMoviesPage(),
    ),
  ],
);
