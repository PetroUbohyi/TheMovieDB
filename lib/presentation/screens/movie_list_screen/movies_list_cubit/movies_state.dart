part of 'movies_cubit.dart';

@immutable
abstract class MoviesState {}

class MoviesInitialState extends MoviesState {}

class MoviesLoadingState extends MoviesState {}

class MoviesLoadedState extends MoviesState {
  final List<Movie> movies;

  MoviesLoadedState({required this.movies})
      : assert(movies != null);
}

class MoviesErrorState extends MoviesState {}
