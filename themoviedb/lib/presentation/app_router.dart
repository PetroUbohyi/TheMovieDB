import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/constants/strings.dart';
import 'package:themoviedb/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:themoviedb/cubit/movies/movies_cubit.dart';
import 'package:themoviedb/data/api_client.dart';
import 'package:themoviedb/data/models/credits.dart';
import 'package:themoviedb/data/repository.dart';
import 'package:themoviedb/presentation/screens/actors_list_screen.dart';
import 'package:themoviedb/presentation/screens/movie_details_screen.dart';
import 'package:themoviedb/presentation/screens/movies_list_screen.dart';
import 'package:themoviedb/presentation/screens/unknown_screen.dart';

class AppRouter {
  late Repository repository;
  late MoviesCubit moviesCubit;
  late MovieDetailCubit movieDetailCubit;

  AppRouter() {
    repository = Repository(apiClient: ApiClient());
    moviesCubit = MoviesCubit(repository: repository);
    movieDetailCubit = MovieDetailCubit(
      repository: repository,
    );
  }

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
        final credits = arguments is Credits ? arguments : null;
        return MaterialPageRoute(
            builder: (_) => ActorsListScreen(
                  credits: credits!,
                ));
      default:
        return MaterialPageRoute(builder: (_) => UnknownScreen());
    }
  }
}
