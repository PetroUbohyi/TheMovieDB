import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:themoviedb/data/models/movie_details.dart';
import 'package:themoviedb/data/repository.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final Repository repository;

  MovieDetailCubit({required this.repository})
      : super(MoviesInitialState());

  void getDetailsMovie(int movieId) async {
    emit(MovieDetailLoadingState());
    await repository.getMovieDetail(movieId).then((movieDetails) {
      emit(MovieDetailLoadedState(movieDetails: movieDetails));
    });
  }
}
