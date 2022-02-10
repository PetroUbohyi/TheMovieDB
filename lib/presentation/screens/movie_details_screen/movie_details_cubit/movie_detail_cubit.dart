import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:themoviedb/data/models/credits_model/credits.dart';
import 'package:themoviedb/data/models/movie_details_model/movie_details.dart';
import 'package:themoviedb/data/networking/movie_repository.dart';
import 'package:themoviedb/locator.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(MoviesInitialState());
  final MovieRepository _repository = locator.get<MovieRepository>();

  void getDetailsMovie(int movieId) async {
    emit(MovieDetailLoadingState());
    var credits = await _repository.getCastAndCrew(movieId);
    await _repository.getMovieDetail(movieId).then((movieDetails) {
      emit(
          MovieDetailLoadedState(movieDetails: movieDetails, credits: credits));
    });
  }
}
