import 'package:flutter/material.dart';
import 'package:themoviedb/constants/strings.dart';
import 'package:themoviedb/data/models/movie.dart';

class MoviesListScreen extends StatelessWidget {
  const MoviesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movie = Movie(
        title: "Spider-Man",
        description: 'Piter Parker, young man how bit electonic and s1mple',
        releaseDate: DateTime(5, 1, 2002));
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB'),
      ),
      body: Center(
        child: Text('Movie list screen'),
      ),
    );
  }
}
