part of 'cast_crew_cubit.dart';

@immutable
abstract class CastCrewState {}

class CastCrewInitialState extends CastCrewState {}

class CastCrewLoadingState extends CastCrewState {}

class CastCrewLoadedState extends CastCrewState {
  final List<CastCrewUIModel> castCrewUI;

  CastCrewLoadedState({required this.castCrewUI}) : assert(castCrewUI != null);
}

class CastCrewErrorState extends CastCrewState {}
