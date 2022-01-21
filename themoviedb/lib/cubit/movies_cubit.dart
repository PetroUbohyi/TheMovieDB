import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:themoviedb/data/api_client.dart';
import 'package:themoviedb/data/models/movie.dart';
import 'package:themoviedb/data/models/movie_response.dart';
import 'package:themoviedb/data/repository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final Repository repository;

  MoviesCubit({required this.repository}) : super(MoviesInitialState());

  void fetchMovies() async {
    emit(MoviesLoadingState());
    print("LOADING STATE:");
    await repository.fetchMovie().then((movies) {
      print('MOVIE: $movies');
      print(movies[0].title);
      print(movies[1].title);
      print(movies[2].title);
      print(movies[3].title);
      emit(MoviesLoadedState(movies: movies));
    });
    print('LOADED STATE:');
  }
}
