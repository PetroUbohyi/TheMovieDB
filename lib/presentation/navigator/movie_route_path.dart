class MovieRoutePath {
  final int? id;
  final int? castCrewId;

  MovieRoutePath.home()
      : id = null,
        castCrewId = null;

  MovieRoutePath.details(this.id) : castCrewId = null;

  MovieRoutePath.castCrewList(this.id, this.castCrewId);

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;

  bool get isActorsListPage => castCrewId != null;
}
