import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/core/routing/router.dart';
import 'package:movies_app/features/movies/presentation/cubits/popular_movies_cubit.dart';
import 'package:movies_app/features/movies/presentation/cubits/search_movies_cubit.dart';
import 'core/api/tmdb_api.dart';
import 'features/movies/data/movie_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final tmdbApi = TmdbApi();
  final repository = MovieRepository(tmdbApi);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final MovieRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PopularMoviesCubit(repository)),
        BlocProvider(create: (_) => SearchMoviesCubit(repository)),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'Movies App',
      ),
    );
  }
}
