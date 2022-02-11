class MovieUIModel {
  final int id;
  final String title;
  final String? posterPath;
  final String? releaseDate;
  final String overview;

  MovieUIModel(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.releaseDate,
      required this.overview});
}
