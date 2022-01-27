import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:themoviedb/data/models/credits.dart';
import 'package:themoviedb/data/repository.dart';

part 'cast_crew_state.dart';

class CastCrewCubit extends Cubit<CastCrewState> {
  final Repository repository;

  CastCrewCubit({required this.repository}) : super(CastCrewInitialState());

  void fetchCastCrew(int movieId) async {
    emit(CastCrewLoadingState());
    await repository.castAndCrew(movieId).then((credits) {
      emit(CastCrewLoadedState(credits: credits));
    });
  }
}
