import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../features/movies/data/movie_model.dart';

class TmdbApi {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      headers: {
        'Authorization': 'Bearer ${dotenv.env['TMDB_API_KEY']}',
        'accept': 'application/json',
        'Content-Type': 'application/json;charset=utf-8',
      },
    ),
  );

  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    final response = await _dio.get(
      '/movie/popular',
      queryParameters: {'page': page, 'language': 'pt-BR'},
    );
    final results = response.data['results'] as List;
    return results.map((json) => MovieModel.fromJson(json)).toList();
  }

  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await _dio.get('/search/movie', queryParameters: {
        'query': query,
        'language': 'pt-BR',
      });

      final results = response.data['results'] as List;
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Autenticação inválida');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Filme não encontrado');
      } else {
        throw Exception('Erro no servidor');
      }
    } on SocketException {
      throw Exception('Conecte-se à internet');
    } catch (_) {
      throw Exception('Erro desconhecido');
    }
  }

  Future<int?> getMovieRuntime(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId', queryParameters: {
        'language': 'pt-BR',
      });

      return response.data['runtime'] as int?;
    } catch (_) {
      return null;
    }
  }
}
