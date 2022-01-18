import 'package:flutter/material.dart';
import 'package:themoviedb/presentation/app_router.dart';
import 'package:themoviedb/presentation/screens/movies_list_screen.dart';

void main() {
  runApp(TheMovieDBApp(
    router: AppRouter(),
  ));
}

class TheMovieDBApp extends StatelessWidget {
  final AppRouter router;

  const TheMovieDBApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}
