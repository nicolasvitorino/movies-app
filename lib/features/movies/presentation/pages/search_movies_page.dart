import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movies/data/movie_model.dart';
import 'package:movies_app/features/movies/presentation/cubits/search_movies_cubit.dart';
import 'package:movies_app/features/movies/presentation/widgets/movie_navigation_menu.dart';
import 'package:movies_app/features/movies/presentation/widgets/movie_search_bar.dart';

class SearchMoviesPage extends StatefulWidget {
  const SearchMoviesPage({super.key});

  @override
  State<SearchMoviesPage> createState() => _SearchMoviesPageState();
}

class _SearchMoviesPageState extends State<SearchMoviesPage> {
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Busca',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
      body: Container(
        color: const Color(0xFF1A1A1A),
        child: Column(
          children: [
            MovieSearchBar(
              onSearch: (query) {
                context.read<SearchMoviesCubit>().search(query);
              },
            ),
            Expanded(
              child: BlocBuilder<SearchMoviesCubit, SearchMoviesState>(
                builder: (context, state) {
                  if (state is SearchMoviesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchMoviesError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    );
                  } else if (state is SearchMoviesLoaded) {
                    if (state.movies.isEmpty) {
                      return const Center(
                        child: Text(
                          'Nenhum filme encontrado.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: state.movies.length,
                      separatorBuilder: (context, index) =>
                          FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Container(
                          height: 1,
                          color: Colors.white10,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        final MovieModel movie = state.movies[index];
                        if (movie.posterPath.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            movie.title,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink(); // estado inicial
                },
              ),
            ),
          ],
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
