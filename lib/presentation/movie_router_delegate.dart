import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/cubit/movies/movies_cubit.dart';
import 'package:themoviedb/data/models/movie.dart';
import 'package:themoviedb/presentation/screens/movie_details_screen.dart';
import 'package:themoviedb/presentation/screens/movie_route_path.dart';
import 'package:themoviedb/presentation/screens/movies_list_screen.dart';


class MovieRouterDelegate extends RouterDelegate<MovieRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MovieRoutePath> {

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  Movie? _selectedMovie;
  final MoviesCubit moviesCubit;

  MovieRouterDelegate({required this.moviesCubit})
      : navigatorKey = GlobalKey<NavigatorState>();

  @override
  MovieRoutePath get currentConfiguration =>
      _selectedMovie == null
          ? MovieRoutePath.home()
          : MovieRoutePath.details(moviesCubit.movies.indexOf(_selectedMovie!));

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: const ValueKey('BooksListPage'),
          child: MoviesListScreen(),
        ),
        if (_selectedMovie != null)
          MaterialPage(
              child: MovieDetailsScreen(movie: _selectedMovie,)
          )

      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        _selectedMovie = null;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(MovieRoutePath configuration) async {
    if (configuration.isDetailsPage) {
      _selectedMovie = moviesCubit.movies[configuration.id!];
    }
  }

  void _handleBookTapped(Movie movie) {
    _selectedMovie = movie;
    notifyListeners();
  }
}