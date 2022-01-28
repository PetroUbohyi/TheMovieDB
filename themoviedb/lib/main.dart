import 'package:flutter/material.dart';
import 'package:themoviedb/cubit/cast_crew/cast_crew_cubit.dart';
import 'package:themoviedb/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:themoviedb/cubit/movies/movies_cubit.dart';
import 'package:themoviedb/data/api_client.dart';
import 'package:themoviedb/data/movie_repository.dart';
import 'package:themoviedb/presentation/app_router.dart';
import 'package:themoviedb/presentation/screens/movies_list_screen.dart';
import 'package:themoviedb/theme/app_colors.dart';
import 'package:themoviedb/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient apiClient = ApiClient();
  MovieRepository movieRepository = MovieRepository(apiClient: apiClient);
  runApp(TheMovieDBApp(
    router: AppRouter(
      repository: movieRepository,
      castCrewCubit: CastCrewCubit(repository: movieRepository),
      movieDetailCubit: MovieDetailCubit(repository: movieRepository),
      moviesCubit: MoviesCubit(repository: movieRepository),
    ),
  ));
}

class TheMovieDBApp extends StatelessWidget {
  final AppRouter router;

  const TheMovieDBApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Movie DB',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}
