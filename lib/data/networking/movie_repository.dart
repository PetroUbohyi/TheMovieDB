import 'package:themoviedb/data/networking/api_client.dart';
import 'package:themoviedb/data/models/credits_model/credits.dart';
import 'package:themoviedb/data/models/movie_details_model/movie_details.dart';
import 'package:themoviedb/data/models/movie_response_model/movie_response.dart';

import '../../locator.dart';

class MovieRepository {
  MovieRepository();

  Future<MovieResponse> fetchMovie(int page, String filter) =>
      locator.get<ApiClient>().fetchMovies(page, filter);

  Future<MovieDetails> getMovieDetail(int movieId) =>
      locator.get<ApiClient>().detailsMovie(movieId);

  Future<Credits> getCastAndCrew(int movieId) =>
      locator.get<ApiClient>().getCastAndCrew(movieId);

  Future<MovieResponse> searchMovie(int page, String query) =>
      locator.get<ApiClient>().searchMovie(page, query);
}
