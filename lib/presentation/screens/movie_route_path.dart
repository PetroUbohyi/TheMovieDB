class MovieRoutePath {
  final int? id;

  MovieRoutePath.home() : id = null;

  MovieRoutePath.details(this.id);

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;
}