import 'package:flutter/material.dart';

import 'package:themoviedb/locator.dart';
import 'package:themoviedb/presentation/navigator/movie_route_information_parser.dart';
import 'package:themoviedb/presentation/navigator/movie_router_delegate.dart';
import 'package:themoviedb/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(TheMovieDBApp());
}

class TheMovieDBApp extends StatelessWidget {
  final MovieRouterDelegate routerDelegate = MovieRouterDelegate();

  final MovieRouteInformationParser routeInformationParser =
      MovieRouteInformationParser();

  TheMovieDBApp({Key? key}) : super(key: key);

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
