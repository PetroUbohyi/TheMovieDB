import 'package:flutter/material.dart';
import 'package:themoviedb/data/networking/api_client.dart';
import 'package:themoviedb/data/networking/movie_repository.dart';
import 'package:themoviedb/presentation/navigator/movie_route_information_parser.dart';
import 'package:themoviedb/presentation/navigator/movie_router_delegate.dart';
import 'package:themoviedb/presentation/screens/movie_list_screen/movies_list_cubit/movies_cubit.dart';
import 'package:themoviedb/theme/app_theme.dart';

import 'presentation/screens/actors_list_screen/actors_list_cubit/cast_crew_cubit.dart';
import 'presentation/screens/movie_details_screen/movie_details_cubit/movie_detail_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient apiClient = ApiClient();
  MovieRepository movieRepository = MovieRepository(apiClient: apiClient);
  final app = TheMovieDBApp(
    routerDelegate: MovieRouterDelegate(
        moviesCubit: MoviesCubit(repository: movieRepository),
        movieDetailCubit: MovieDetailCubit(repository: movieRepository),
        castCrewCubit: CastCrewCubit(repository: movieRepository)),
  );
  runApp(app);
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
