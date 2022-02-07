import 'package:flutter/material.dart';
import 'package:themoviedb/cubit/cast_crew/cast_crew_cubit.dart';
import 'package:themoviedb/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:themoviedb/cubit/movies/movies_cubit.dart';
import 'package:themoviedb/data/api_client.dart';
import 'package:themoviedb/data/movie_repository.dart';
import 'package:themoviedb/presentation/movie_route_information_parser.dart';
import 'package:themoviedb/presentation/movie_router_delegate.dart';
import 'package:themoviedb/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient apiClient = ApiClient();
  MovieRepository movieRepository = MovieRepository(apiClient: apiClient);
  runApp(TheMovieDBApp(
    routerDelegate: MovieRouterDelegate(
        moviesCubit: MoviesCubit(repository: movieRepository),
        movieDetailCubit: MovieDetailCubit(repository: movieRepository),
        castCrewCubit: CastCrewCubit(repository: movieRepository)),
  ));
}

class TheMovieDBApp extends StatelessWidget {
  final MovieRouterDelegate routerDelegate;
  final MovieRouteInformationParser routeInformationParser =
      MovieRouteInformationParser();

  TheMovieDBApp({Key? key, required this.routerDelegate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      title: 'The Movie DB',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routeInformationParser: routeInformationParser,
    );
  }
}
