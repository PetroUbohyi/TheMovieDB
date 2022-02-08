import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/cubit/cast_crew/cast_crew_cubit.dart';
import 'package:themoviedb/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:themoviedb/cubit/movies/movies_cubit.dart';
import 'package:themoviedb/data/models/movie.dart';
import 'package:themoviedb/presentation/screens/actors_list_screen.dart';
import 'package:themoviedb/presentation/screens/movie_details_screen.dart';
import 'package:themoviedb/presentation/movie_route_path.dart';
import 'package:themoviedb/presentation/screens/movies_list_screen.dart';

class MovieRouterDelegate extends RouterDelegate<MovieRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MovieRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  Movie? _selectedMovie;
  int? _selectedCastCrew;
  final MoviesCubit moviesCubit;
  final MovieDetailCubit movieDetailCubit;
  final CastCrewCubit castCrewCubit;

  MovieRouterDelegate(
      {required this.castCrewCubit,
      required this.movieDetailCubit,
      required this.moviesCubit})
      : navigatorKey = GlobalKey<NavigatorState>();

  @override
  MovieRoutePath get currentConfiguration {
    if (_selectedMovie == null && _selectedCastCrew == null) {
      return MovieRoutePath.home();
    } else if (_selectedMovie != null && _selectedCastCrew == null) {
      return MovieRoutePath.details(
          moviesCubit.movies.indexOf(_selectedMovie!));
    } else {
      return MovieRoutePath.castCrewList(
          moviesCubit.movies.indexOf(_selectedMovie!), _selectedCastCrew);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: BlocProvider.value(
            value: moviesCubit,
            child: MoviesListScreen(
              onTapped: _handleMovieTapped,
            ),
          ),
        ),
        if (_selectedMovie != null && _selectedCastCrew == null)
          MaterialPage(
            child: BlocProvider.value(
              value: movieDetailCubit,
              child: MovieDetailsScreen(
                onTapped: _handleCastCrewTapped,
                movie: _selectedMovie,
              ),
            ),
          ),
        if (_selectedCastCrew != null)
          MaterialPage(
              child: BlocProvider.value(
            value: castCrewCubit,
            child: ActorsListScreen(
              movieId: _selectedMovie!.id,
            ),
          ))
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        if (_selectedCastCrew != null) {
          _selectedCastCrew = null;
          notifyListeners();
          return true;
        }

        if (_selectedMovie != null) {
          _selectedMovie = null;
          notifyListeners();
          return true;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(MovieRoutePath configuration) async {
    if (configuration.isDetailsPage) {
      _selectedMovie = moviesCubit.movies[configuration.id!];
      _selectedCastCrew = null;
    }
    if (configuration.isActorsListPage) {
      _selectedCastCrew = moviesCubit.movies[configuration.id!].id;
    }
  }

  void _handleMovieTapped(Movie movie) {
    _selectedMovie = movie;
    notifyListeners();
  }

  void _handleCastCrewTapped(int movieId) {
    _selectedCastCrew = movieId;
    notifyListeners();
  }
}
