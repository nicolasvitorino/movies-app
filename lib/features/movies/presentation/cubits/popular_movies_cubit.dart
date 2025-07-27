import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:movies_app/features/movies/data/movie_model.dart';
import 'package:movies_app/features/movies/data/movie_repository.dart';

abstract class PopularMoviesState {}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesLoaded extends PopularMoviesState {
  final List<MovieModel> movies;
  PopularMoviesLoaded(this.movies);
}

class PopularMoviesError extends PopularMoviesState {
  final String message;

  PopularMoviesError(this.message);
}

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final MovieRepository repository;

  int _currentPage = 1;
  bool _isLoadingMore = false;
  List<MovieModel> _allMovies = [];

  PopularMoviesCubit(this.repository) : super(PopularMoviesInitial());

  Future<void> fetchMovies() async {
    try {
      emit(PopularMoviesLoading());
      final movies = await repository.getPopularMovies(page: _currentPage);
      emit(PopularMoviesLoaded(movies));
    } on SocketException {
      emit(PopularMoviesError(
          'Aplicativo offline.Conecte-se à internet e reinicie o aplicativo'));
    } catch (e) {
      emit(PopularMoviesError(
          'Erro ao carregar filmes. Recarregue seu aplicativo.'));
    }
  }

  Future<void> fetchMoreMovies() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;

    try {
      _currentPage++;
      final newMovies = await repository.getPopularMovies(page: _currentPage);
      _allMovies.addAll(newMovies);
      emit(PopularMoviesLoaded(List.from(_allMovies)));
    } catch (_) {
      emit(PopularMoviesError('Erro ao carregar mais filmes'));
    } finally {
      _isLoadingMore = false;
    }
  }
}
