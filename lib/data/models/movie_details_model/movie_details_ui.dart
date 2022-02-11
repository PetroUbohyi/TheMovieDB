import 'package:themoviedb/data/models/movie_details_model/movie_details.dart';

class MovieDetailsUIModel {
  final int id;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double voteAverage;
  final int? runtime;
  final List<ProductionCountrie> productionCountries;
  final List<Genre> genres;
  final String? tagline;
  final String? overview;

  MovieDetailsUIModel(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.backdropPath,
      required this.releaseDate,
      required this.voteAverage,
      required this.runtime,
      required this.productionCountries,
      required this.genres,
      required this.tagline,
      required this.overview});
}
