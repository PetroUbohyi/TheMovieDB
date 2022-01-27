part of 'cast_crew_cubit.dart';

@immutable
abstract class CastCrewState {}

class CastCrewInitialState extends CastCrewState {}

class CastCrewLoadingState extends CastCrewState {}

class CastCrewLoadedState extends CastCrewState {
  final Credits credits;

  CastCrewLoadedState({required this.credits}) : assert(credits != null);
}

class CastCrewErrorState extends CastCrewState {}
