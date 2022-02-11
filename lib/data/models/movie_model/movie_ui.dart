class MovieUIModel {
  final int movieId;
  final String title;
  final String? posterPath;
  final String? releaseDate;
  final String overview;

  MovieUIModel(
      {required this.movieId,
      required this.title,
      required this.posterPath,
      required this.releaseDate,
      required this.overview});
}
