import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/features/movies/data/movie_model.dart';
import 'package:movies_app/features/movies/data/movie_repository.dart';

abstract class SearchMoviesState {}

class SearchMoviesInitial extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesLoaded extends SearchMoviesState {
  final List<MovieModel> movies;
  SearchMoviesLoaded(this.movies);
}

class SearchMoviesError extends SearchMoviesState {
  final String message;
  SearchMoviesError(this.message);
}

class SearchMoviesCubit extends Cubit<SearchMoviesState> {
  final MovieRepository repository;

  SearchMoviesCubit(this.repository) : super(SearchMoviesInitial());

  Future<void> search(String query) async {
    try {
      emit(SearchMoviesLoading());
      final movies = await repository.searchMovies(query);
      emit(SearchMoviesLoaded(movies));
    } on SocketException {
      emit(SearchMoviesError(
          'Aplicativo offline.Conecte-se à internet e reinicie o aplicativo'));
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erro: $e');

      emit(SearchMoviesError('Erro na busca'));
    }
  }
}
