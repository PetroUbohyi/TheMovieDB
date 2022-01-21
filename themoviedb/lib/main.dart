import 'package:flutter/material.dart';
import 'package:themoviedb/presentation/app_router.dart';
import 'package:themoviedb/presentation/screens/movies_list_screen.dart';
import 'package:themoviedb/theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'The Movie DB',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.mainAppColor),

      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}
