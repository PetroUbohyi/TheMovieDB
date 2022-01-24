import 'package:themoviedb/data/models/movie.dart';
import 'package:dio/dio.dart';
import 'package:themoviedb/data/models/movie_details.dart';

class ApiClient {
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '2913a7cd055791a93a885f2e5f37e684';

  static String imageUrl(String path) => _imageUrl + path;

  var _dio = Dio();

  Future<List<Movie>> topRatedMovies() async {
    try {
      final url = '$_host/movie/top_rated?api_key=$_apiKey';
      final response = await _dio.get(url);
      var movies = await response.data['results'] as List;
      List<Movie> movieList = movies.map((v) => Movie.fromJson(v)).toList();
      return movieList;
    } catch (e) {
      throw Exception('Exception with error: $e');
    }
  }

  Future<MovieDetails> detailsMovie(int movieId) async {
    try {
      final url = '$_host/movie/$movieId?api_key=$_apiKey';
      final response = await _dio.get(url);
      var movieDetails = await response.data;
      MovieDetails movieDetailsResult = MovieDetails.fromJson(movieDetails);
      return movieDetailsResult;
    } catch (e) {
      throw Exception('Exception with error: $e');
    }
  }
}
