import 'package:themoviedb/data/models/credits.dart';
import 'package:themoviedb/data/models/movie.dart';
import 'package:dio/dio.dart';
import 'package:themoviedb/data/models/movie_details.dart';
import 'package:themoviedb/data/models/movie_response.dart';
import 'package:themoviedb/enviroment/enviroment.dart';

class ApiClient {
  static const _host = Environment.HOST;
  static const _apiKey = Environment.API_KEY;
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';

  static String imageUrl(String path) => _imageUrl + path;

  var _dio = Dio();

  Future<MovieResponse> fetchMovies(int page, String filter) async {
    try {
      final url = '$_host/movie/$filter?api_key=$_apiKey';
      final parameters = <String, dynamic>{
        'page': page,
      };
      final response = await _dio.get(url, queryParameters: parameters);
      var movies = await response.data as Map<String, dynamic>;
      MovieResponse result = MovieResponse.fromJson(movies);
      return result;
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

  Future<Credits> getCastAndCrew(int movieId) async {
    try {
      final url = '$_host/movie/$movieId/credits?api_key=$_apiKey';
      final response = await _dio.get(url);
      var castAndCrew = await response.data;
      Credits castAndCrewResult = Credits.fromJson(castAndCrew);
      return castAndCrewResult;
    } catch (e) {
      throw Exception('Exception with error: $e');
    }
  }
}
