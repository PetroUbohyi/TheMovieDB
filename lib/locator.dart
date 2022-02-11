import 'package:get_it/get_it.dart';
import 'package:themoviedb/data/networking/api_client.dart';
import 'package:themoviedb/data/networking/movie_repository.dart';
import 'package:themoviedb/presentation/screens/actors_list_screen/actors_list_cubit/cast_crew_cubit.dart';
import 'package:themoviedb/presentation/screens/movie_details_screen/movie_details_cubit/movie_detail_cubit.dart';
import 'package:themoviedb/presentation/screens/movie_list_screen/movies_list_cubit/movies_cubit.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<MovieRepository>(() => MovieRepository());
  locator.registerLazySingleton<ApiClient>(() => ApiClient());
  locator.registerLazySingleton<MoviesCubit>(() => MoviesCubit());
  locator.registerLazySingleton<MovieDetailCubit>(() => MovieDetailCubit());
  locator.registerLazySingleton<CastCrewCubit>(() => CastCrewCubit());
}
