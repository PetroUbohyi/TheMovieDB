import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:themoviedb/data/models/movie.dart';
import 'package:themoviedb/data/models/movie_response.dart';
import 'package:themoviedb/data/movie_repository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MovieRepository repository;
  final _movies = <Movie>[];
  int _currentPage = 0;
  int _totalPage = 1;

  List<Movie> get movies => List.unmodifiable(_movies);

  MoviesCubit({required this.repository}) : super(MoviesInitialState());

  Future<MovieResponse> fetchMovies(int page, String filter) async {
    return await repository.fetchMovie(page, filter);
  }

  Future<void> loadMovies(String filter) async {
    if (_movies.length == 0) {
      emit(MoviesLoadingState());
    }
    if (_currentPage >= _totalPage) return;
    final nextPage = _currentPage + 1;
    try {
      final movieResponse = await fetchMovies(nextPage, filter);
      _movies.addAll(movieResponse.movies);
      _currentPage = movieResponse.page;
      _totalPage = movieResponse.totalPages;
      print("MOVIESSSS: ${_movies.length}");
      emit(MoviesLoadedState(movies: _movies));
    } catch (e) {
    }
  }

  void showedMovieAtIndex(int index, String filter) {
    if (index < _movies.length - 1) {
        return;
    }
    loadMovies(filter);
  }

  void filterSelected(String filter) {
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    loadMovies(filter);
  }
}
