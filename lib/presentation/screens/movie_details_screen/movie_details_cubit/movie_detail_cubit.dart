import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:themoviedb/data/models/credits_model/credits.dart';
import 'package:themoviedb/data/models/movie_details_model/movie_details.dart';
import 'package:themoviedb/data/networking/movie_repository.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final MovieRepository repository;

  MovieDetailCubit({required this.repository}) : super(MoviesInitialState());

  void getDetailsMovie(int movieId) async {
    emit(MovieDetailLoadingState());
    var credits = await repository.getCastAndCrew(movieId);
    await repository.getMovieDetail(movieId).then((movieDetails) {
      emit(
          MovieDetailLoadedState(movieDetails: movieDetails, credits: credits));
    });
  }

}
