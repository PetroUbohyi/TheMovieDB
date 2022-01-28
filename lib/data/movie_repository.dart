import 'package:themoviedb/data/api_client.dart';
import 'package:themoviedb/data/models/CastCrewUIModel.dart';
import 'package:themoviedb/data/models/credits.dart';
import 'package:themoviedb/data/models/movie.dart';
import 'package:themoviedb/data/models/movie_details.dart';
import 'package:themoviedb/data/models/movie_response.dart';

class MovieRepository {
  final ApiClient apiClient;

  MovieRepository({required this.apiClient});

  Future<MovieResponse> fetchMovie(int page, String filter) async {
    final movieList = apiClient.fetchMovies(page, filter);
    return movieList;
  }

  Future<MovieDetails> getMovieDetail(int movieId) async {
    final movieDetailsList = apiClient.detailsMovie(movieId);
    return movieDetailsList;
  }

  Future<Credits> castAndCrew(int movieId) async {
    final castAndCrewList = await apiClient.getCastAndCrew(movieId);
    return castAndCrewList;
  }

  Future<List<CastCrewUIModel>> mapCreditsToCastCrewUIModel(int movieId) async {
    final credits = await apiClient.getCastAndCrew(movieId);
    List<CastCrewUIModel> castCrewUIList = [];
    var castList = credits.cast;
    var crewList = credits.crew;
    print('LENGHT CREDITS: ${castList.length + crewList.length}');
    for (var i = 0; i < castList.length; i++) {
      var networkCastModel = castList[i];
      var uiCastModel = CastCrewUIModel(
          id: networkCastModel.id,
          name: networkCastModel.name,
          profilePath: networkCastModel.profilePath,
          characterOrDepartment: networkCastModel.character);
      castCrewUIList.add(uiCastModel);
    }

    for (var i = 0; i < crewList.length; i++) {
      var networkCrewModel = crewList[i];
      var uiCrewModel = CastCrewUIModel(
          id: networkCrewModel.id,
          name: networkCrewModel.name,
          profilePath: networkCrewModel.profilePath,
          characterOrDepartment: networkCrewModel.department);
      castCrewUIList.add(uiCrewModel);
    }
    print("LENGHT CAST CREW LIST UI: ${castCrewUIList.length}");
    return castCrewUIList;
  }
}
