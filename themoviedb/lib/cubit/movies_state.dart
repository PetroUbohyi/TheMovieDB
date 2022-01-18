part of 'movies_cubit.dart';

@immutable
abstract class MoviesState {}

class MovieInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}