import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/constants/strings.dart';
import 'package:themoviedb/cubit/cast_crew/cast_crew_cubit.dart';
import 'package:themoviedb/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:themoviedb/cubit/movies/movies_cubit.dart';
import 'package:themoviedb/data/api_client.dart';
import 'package:themoviedb/data/movie_repository.dart';
import 'package:themoviedb/presentation/screens/actors_list_screen.dart';
import 'package:themoviedb/presentation/screens/movie_details_screen.dart';
import 'package:themoviedb/presentation/screens/movies_list_screen.dart';
import 'package:themoviedb/presentation/screens/unknown_screen.dart';

class AppRouter {
  final MovieRepository repository;
  final MoviesCubit moviesCubit;
  final MovieDetailCubit movieDetailCubit;
  final CastCrewCubit castCrewCubit;

  AppRouter(
      {required this.repository,
      required this.moviesCubit,
      required this.movieDetailCubit,
      required this.castCrewCubit}) {}

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: moviesCubit,
            child: MoviesListScreen(),
          ),
        );
      case MOVIE_DETAILS_SCREEN:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: movieDetailCubit,
            child: MovieDetailsScreen(movieId: movieId),
          ),
        );
      case ACTORS_LIST_SCREEN:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: castCrewCubit,
                child: ActorsListScreen(
                  movieId: movieId,
                )));
      default:
        return MaterialPageRoute(builder: (_) => UnknownScreen());
    }
  }
}
