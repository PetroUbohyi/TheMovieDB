import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:themoviedb/data/models/credits_model/credits.dart';
import 'package:themoviedb/data/models/movie_details_model/movie_details_ui.dart';
import 'package:themoviedb/data/networking/movie_repository.dart';
import 'package:themoviedb/locator.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(MoviesInitialState());
  final MovieRepository _repository = locator.get<MovieRepository>();

  void getDetailsMovie(int movieId) async {
    emit(MovieDetailLoadingState());
    var credits = await _repository.getCastAndCrew(movieId);
    var movieDetails =
        await mapNetworkMovieDetailsModelToUIMovieDetailsModel(movieId);
    emit(MovieDetailLoadedState(credits: credits, movieDetails: movieDetails));
  }

  Future<MovieDetailsUIModel> mapNetworkMovieDetailsModelToUIMovieDetailsModel(
      int movieId) async {
    final _networkMovieDetails = await _repository.getMovieDetail(movieId);
    MovieDetailsUIModel movieDetailsUI = MovieDetailsUIModel(
        id: _networkMovieDetails.id,
        title: _networkMovieDetails.title,
        posterPath: _networkMovieDetails.posterPath,
        backdropPath: _networkMovieDetails.backdropPath,
        releaseDate: _networkMovieDetails.releaseDate,
        voteAverage: _networkMovieDetails.voteAverage,
        runtime: _networkMovieDetails.runtime,
        productionCountries: _networkMovieDetails.productionCountries,
        genres: _networkMovieDetails.genres,
        tagline: _networkMovieDetails.tagline,
        overview: _networkMovieDetails.overview);
    return movieDetailsUI;
  }
}
