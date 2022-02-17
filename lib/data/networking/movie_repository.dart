import 'package:themoviedb/data/networking/api_client.dart';
import 'package:themoviedb/data/models/credits_model/credits.dart';
import 'package:themoviedb/data/models/movie_details_model/movie_details.dart';
import 'package:themoviedb/data/models/movie_response_model/movie_response.dart';

import '../../locator.dart';

class MovieRepository {
  MovieRepository();

  final _apiClient = locator.get<ApiClient>();

  Future<MovieResponse> fetchMovie(int page, String filter) =>
      _apiClient.fetchMovies(page, filter);

  Future<MovieDetails> getMovieDetail(int movieId) =>
      _apiClient.detailsMovie(movieId);

  Future<Credits> getCastAndCrew(int movieId) =>
      _apiClient.getCastAndCrew(movieId);

  Future<MovieResponse> searchMovie(int page, String query) =>
      _apiClient.searchMovie(page, query);
}
