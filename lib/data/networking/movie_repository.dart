import 'package:themoviedb/data/networking/api_client.dart';
import 'package:themoviedb/data/models/credits_model/credits.dart';
import 'package:themoviedb/data/models/movie_details_model/movie_details.dart';
import 'package:themoviedb/data/models/movie_response_model/movie_response.dart';

class MovieRepository {
  final ApiClient apiClient;

  MovieRepository({required this.apiClient});

  Future<MovieResponse> fetchMovie(int page, String filter) =>
      apiClient.fetchMovies(page, filter);

  Future<MovieDetails> getMovieDetail(int movieId) =>
      apiClient.detailsMovie(movieId);

  Future<Credits> getCastAndCrew(int movieId) =>
      apiClient.getCastAndCrew(movieId);

  Future<MovieResponse> searchMovie(int page, String query) =>
      apiClient.searchMovie(page, query);
}
