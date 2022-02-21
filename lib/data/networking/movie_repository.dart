import 'package:themoviedb/data/models/credits_model/credits.dart';
import 'package:themoviedb/data/models/movie_details_model/movie_details.dart';
import 'package:themoviedb/data/models/movie_response_model/movie_response.dart';
import 'package:dio/dio.dart';

import '../../environment/enviroment.dart';

class MovieRepository {
  static const _host = Environment.HOST;
  static const _apiKey = Environment.API_KEY;
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  final Dio dio;

  MovieRepository({required this.dio});

  static String imageUrl(String? path) => _imageUrl + path!;

  Future<MovieResponse> fetchMovie(int page, String filter) async {
    try {
      final url = '$_host/movie/$filter?api_key=$_apiKey';
      final parameters = <String, dynamic>{
        'page': page,
      };
      final response = await dio.get(url, queryParameters: parameters);
      var movies = await response.data as Map<String, dynamic>;
      return MovieResponse.fromJson(movies);
    } catch (e) {
      throw Exception('Exception with error: $e');
    }
  }

  Future<MovieDetails> getMovieDetail(int movieId) async {
    try {
      final url = '$_host/movie/$movieId?api_key=$_apiKey';
      final response = await dio.get(url);
      var movieDetails = await response.data;
      return MovieDetails.fromJson(movieDetails);
    } catch (e) {
      throw Exception('Exception with error: $e');
    }
  }

  Future<Credits> getCastAndCrew(int movieId) async {
    try {
      final url = '$_host/movie/$movieId/credits?api_key=$_apiKey';
      final response = await dio.get(url);
      var castAndCrew = await response.data;
      return Credits.fromJson(castAndCrew);
    } catch (e) {
      throw Exception('Exception with error: $e');
    }
  }

  Future<MovieResponse> searchMovie(int page, String query) async {
    try {
      const url = '$_host/search/movie?api_key=$_apiKey';
      final parameters = <String, dynamic>{
        'query': query,
        'page': page,
      };
      final response = await dio.get(url, queryParameters: parameters);
      var result = await response.data as Map<String, dynamic>;
      return MovieResponse.fromJson(result);
    } catch (e) {
      throw Exception("Exception with error: $e");
    }
  }
}
