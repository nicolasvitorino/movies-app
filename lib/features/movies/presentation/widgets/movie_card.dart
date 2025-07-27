import 'package:flutter/material.dart';
import 'package:movies_app/core/api/tmdb_api.dart';
import 'package:movies_app/features/movies/data/movie_model.dart';

class MovieCard extends StatefulWidget {
  final MovieModel movie;
  final TmdbApi api;

  const MovieCard({
    super.key,
    required this.movie,
    required this.api,
  });

  @override
  State<MovieCard> createState() => _MovieListItemState();
}

class _MovieListItemState extends State<MovieCard> {
  String? runtime;

  @override
  void initState() {
    super.initState();
    loadRuntime();
  }

  Future<void> loadRuntime() async {
    final result = await widget.api.getMovieRuntime(widget.movie.id);
    setState(() => runtime = result != null ? formatRuntime(result) : null);
  }

  String formatRuntime(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (hours > 0 && remainingMinutes > 0) {
      return '${hours}h ${remainingMinutes}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${remainingMinutes}m';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF292E34),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            height: 62,
            width: 50,
            fit: BoxFit.cover,
            'https://image.tmdb.org/t/p/w92${widget.movie.posterPath}',
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          ),
        ),
        trailing: Container(
          height: 40,
          width: 40,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xFF2B64DF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            '${(widget.movie.voteAverage * 10).toInt()}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(widget.movie.title,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400)),
        subtitle: Row(
          children: [
            const Icon(
              Icons.access_time,
              color: Colors.white70,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              runtime ?? 'Não disponível',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
