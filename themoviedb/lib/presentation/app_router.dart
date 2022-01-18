import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/constants/strings.dart';
import 'package:themoviedb/cubit/movies_cubit.dart';
import 'package:themoviedb/presentation/screens/actors_list_screen.dart';
import 'package:themoviedb/presentation/screens/movie_details_screen.dart';
import 'package:themoviedb/presentation/screens/movies_list_screen.dart';
import 'package:themoviedb/presentation/screens/unknown_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => MoviesCubit(), child: MoviesListScreen()));
      case MOVIE_DETAILS_SCREEN:
        return MaterialPageRoute(builder: (_) => MovieDetailsScreen());
      case ACTORS_LIST_SCREEN:
        return MaterialPageRoute(builder: (_) => ActorsListScreen());
      default:
        return MaterialPageRoute(builder: (_) => UnknownScreen());
    }
  }
}
