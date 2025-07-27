class MovieModel {
  final int id;
  final String title;
  final double voteAverage;
  final String posterPath;

  MovieModel({
    required this.id,
    required this.title,
    required this.voteAverage,
    required this.posterPath,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      voteAverage: json['vote_average'] ?? 0,
      posterPath: json['poster_path'] ?? '',
    );
  }
}
