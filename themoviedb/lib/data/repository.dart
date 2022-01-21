import 'package:themoviedb/data/api_client.dart';
import 'package:themoviedb/data/models/movie.dart';

class Repository {
  final ApiClient apiClient;

  Repository({required this.apiClient});

  Future<List<Movie>> fetchMovie() async {
    final movieList = apiClient.topRatedMovies();
    print('Movie LIST: $movieList');
    return movieList;
  }



}