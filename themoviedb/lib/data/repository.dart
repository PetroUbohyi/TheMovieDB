import 'package:themoviedb/data/api_client.dart';
import 'package:themoviedb/data/models/movie.dart';
import 'package:themoviedb/data/models/movie_details.dart';

class Repository {
  final ApiClient apiClient;

  Repository({required this.apiClient});

  Future<List<Movie>> fetchMovie() async {
    final movieList = apiClient.topRatedMovies();
    return movieList;
  }

  Future<MovieDetails> getMovieDetail(int movieId) async {
    final movieDetailsList = apiClient.detailsMovie(movieId);
    return movieDetailsList;
  }



}