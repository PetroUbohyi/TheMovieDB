import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:themoviedb/data/models/credits_model/CastCrewUIModel.dart';
import 'package:themoviedb/data/networking/movie_repository.dart';
import 'package:themoviedb/locator.dart';

part 'cast_crew_state.dart';

class CastCrewCubit extends Cubit<CastCrewState> {
  CastCrewCubit() : super(CastCrewInitialState());

  final MovieRepository _repository = locator.get<MovieRepository>();

  void fetchCastCrew(int movieId) async {
    emit(CastCrewLoadingState());
    await mapCreditsToCastCrewUIModel(movieId).then((castCrewUI) {
      emit(CastCrewLoadedState(castCrewUI: castCrewUI));
    });
  }

  Future<List<CastCrewUIModel>> mapCreditsToCastCrewUIModel(int movieId) async {
    final credits = await _repository.getCastAndCrew(movieId);
    List<CastCrewUIModel> castCrewUIList = [];
    List<CastCrewUIModel> castUIList = credits.cast.map((networkCastModel) {
      return CastCrewUIModel(
          id: networkCastModel.id,
          name: networkCastModel.name,
          profilePath: networkCastModel.profilePath,
          characterOrDepartment: networkCastModel.character);
    }).toList();
    List<CastCrewUIModel> crewUIList = credits.crew.map((networkCrewModel) {
      return CastCrewUIModel(
          id: networkCrewModel.id,
          name: networkCrewModel.name,
          profilePath: networkCrewModel.profilePath,
          characterOrDepartment: networkCrewModel.department);
    }).toList();
    castCrewUIList = castUIList + crewUIList;
    return castCrewUIList;
  }
}
