import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/api/tmdb_api.dart';
import 'package:movies_app/features/movies/data/movie_model.dart';
import 'package:movies_app/features/movies/presentation/cubits/popular_movies_cubit.dart';
import 'package:movies_app/features/movies/presentation/widgets/movie_card.dart';
import 'package:movies_app/features/movies/presentation/widgets/movie_navigation_menu.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({super.key});

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  int currentIndex = 0;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);

    context.read<PopularMoviesCubit>().fetchMovies();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PopularMoviesCubit>().fetchMoreMovies();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes Populares',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w700)),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
      body: Container(
        color: const Color(0xFF1A1A1A),
        child: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
          builder: (context, state) {
            if (state is PopularMoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PopularMoviesError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is PopularMoviesLoaded) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final MovieModel movie = state.movies[index];
                  return MovieCard(movie: movie, api: TmdbApi());
                },
              );
            }

            return const Center(child: Text('Nenhum filme encontrado.'));
          },
        ),
      ),
      floatingActionButton: MovieNavigationMenu(
        currentIndex: currentIndex,
        onIndexChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
