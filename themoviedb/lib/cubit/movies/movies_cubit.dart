import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:themoviedb/data/models/movie.dart';
import 'package:themoviedb/data/repository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final Repository repository;

  MoviesCubit({required this.repository}) : super(MoviesInitialState());

  void fetchMovies() async {
    emit(MoviesLoadingState());
    await repository.fetchMovie().then((movies) {
      emit(MoviesLoadedState(movies: movies));
    });
  }
}
