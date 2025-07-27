import 'package:movies_app/core/api/tmdb_api.dart';
import 'package:movies_app/features/movies/data/movie_model.dart';

class MovieRepository {
  final TmdbApi api;

  MovieRepository(this.api);

  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    return api.getPopularMovies(page: page);
  }

  Future<List<MovieModel>> searchMovies(String query) async {
    return api.searchMovies(query);
  }
}
