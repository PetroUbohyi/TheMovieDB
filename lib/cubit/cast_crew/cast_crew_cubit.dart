import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:themoviedb/data/models/CastCrewUIModel.dart';
import 'package:themoviedb/data/movie_repository.dart';

part 'cast_crew_state.dart';

class CastCrewCubit extends Cubit<CastCrewState> {
  final MovieRepository repository;

  CastCrewCubit({required this.repository}) : super(CastCrewInitialState());

  void fetchCastCrew(int movieId) async {
    emit(CastCrewLoadingState());
    await repository.mapCreditsToCastCrewUIModel(movieId).then((castCrewUI) {
      emit(CastCrewLoadedState(castCrewUI: castCrewUI));
    });
  }
}
