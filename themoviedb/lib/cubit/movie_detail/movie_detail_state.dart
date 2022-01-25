part of 'movie_detail_cubit.dart';

@immutable
abstract class MovieDetailState {}

class MoviesInitialState extends MovieDetailState {}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailLoadedState extends MovieDetailState {
  final MovieDetails movieDetails;
  final Credits credits;

  MovieDetailLoadedState({required this.credits, required this.movieDetails})
      : assert(movieDetails != null, credits != null);
}

class MoviesErrorState extends MovieDetailState {}
