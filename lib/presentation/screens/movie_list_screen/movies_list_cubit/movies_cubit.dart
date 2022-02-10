import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:themoviedb/data/models/movie_model/movie.dart';
import 'package:themoviedb/data/models/movie_response_model/movie_response.dart';
import 'package:themoviedb/data/networking/movie_repository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MovieRepository repository;
  final _movies = <Movie>[];
  int _currentPage = 0;
  int _totalPage = 1;
  String? _searchQuery;
  Timer? searchDelay;

  List<Movie> get movies => List.unmodifiable(_movies);

  MoviesCubit({required this.repository}) : super(MoviesInitialState());

  Future<MovieResponse> fetchMovies(int page, String filter) async {
    final query = _searchQuery;
    if (query == null) {
      return repository.fetchMovie(page, filter);
    } else {
      return repository.searchMovie(page, query);
    }
  }

  Future<void> loadMovies(String filter) async {
    if (_movies.length == 0 && _searchQuery == null) {
      emit(MoviesLoadingState());
    }
    if (_currentPage >= _totalPage) return;
    final nextPage = _currentPage + 1;
    try {
      final movieResponse = await fetchMovies(nextPage, filter);
      _movies.addAll(movieResponse.movies);
      _currentPage = movieResponse.page;
      _totalPage = movieResponse.totalPages;
      emit(MoviesLoadedState(movies: _movies));
    } catch (e) {}
  }

  void showedMovieAtIndex(int index, String filter) {
    if (index < _movies.length - 1) {
      return;
    }
    loadMovies(filter);
  }

  void resetList([String? filter]) {
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    if (filter == null) {
      loadMovies('top_rated');
    } else {
      loadMovies(filter);
    }
  }

  Future<void> searchMovie(String text) async {
    searchDelay?.cancel();
    searchDelay = Timer(Duration(milliseconds: 300), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;
      resetList('popular');
    });
  }
}
