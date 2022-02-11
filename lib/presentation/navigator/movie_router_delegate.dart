import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/data/models/movie_model/movie_ui.dart';
import 'package:themoviedb/locator.dart';
import 'package:themoviedb/presentation/screens/actors_list_screen/actors_list_screen.dart';
import 'package:themoviedb/presentation/screens/movie_details_screen/movie_details_screen.dart';
import 'package:themoviedb/presentation/navigator/movie_route_path.dart';
import 'package:themoviedb/presentation/screens/movie_list_screen/movies_list_cubit/movies_cubit.dart';
import 'package:themoviedb/presentation/screens/movie_list_screen/movies_list_screen.dart';

import '../screens/actors_list_screen/actors_list_cubit/cast_crew_cubit.dart';
import '../screens/movie_details_screen/movie_details_cubit/movie_detail_cubit.dart';

class MovieRouterDelegate extends RouterDelegate<MovieRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MovieRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  MovieUIModel? _selectedMovie;
  int? _selectedCastCrew;
  final MoviesCubit _moviesCubit = locator.get<MoviesCubit>();
  final MovieDetailCubit _movieDetailCubit = locator.get<MovieDetailCubit>();
  final CastCrewCubit _castCrewCubit = locator.get<CastCrewCubit>();

  MovieRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  MovieRoutePath get currentConfiguration {
    if (_selectedMovie == null && _selectedCastCrew == null) {
      return MovieRoutePath.home();
    } else if (_selectedMovie != null && _selectedCastCrew == null) {
      return MovieRoutePath.details(
          _moviesCubit.movies.indexOf(_selectedMovie!));
    } else {
      return MovieRoutePath.castCrewList(
          _moviesCubit.movies.indexOf(_selectedMovie!), _selectedCastCrew);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: BlocProvider.value(
            value: _moviesCubit,
            child: MoviesListScreen(
              onTapped: _handleMovieTapped,
            ),
          ),
        ),
        if (_selectedMovie != null && _selectedCastCrew == null)
          MaterialPage(
            child: BlocProvider.value(
              value: _movieDetailCubit,
              child: MovieDetailsScreen(
                onTapped: _handleCastCrewTapped,
                movie: _selectedMovie,
              ),
            ),
          ),
        if (_selectedCastCrew != null)
          MaterialPage(
              child: BlocProvider.value(
            value: _castCrewCubit,
            child: ActorsListScreen(
              movieId: _selectedMovie!.movieId,
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
      _selectedMovie = _moviesCubit.movies[configuration.id!];
      _selectedCastCrew = null;
    }
    if (configuration.isActorsListPage) {
      _selectedCastCrew = _moviesCubit.movies[configuration.id!].movieId;
    }
  }

  void _handleMovieTapped(MovieUIModel movie) {
    _selectedMovie = movie;
    notifyListeners();
  }

  void _handleCastCrewTapped(int movieId) {
    _selectedCastCrew = movieId;
    notifyListeners();
  }
}
