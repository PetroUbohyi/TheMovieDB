import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../movie_model/movie.dart';

part 'movie_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieResponse extends Equatable{
  final int page;
  @JsonKey(name: 'results')
  final List<Movie> movies;
  final int totalResults;
  final int totalPages;

  const MovieResponse(
      {required this.page,
      required this.movies,
      required this.totalResults,
      required this.totalPages});

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);

  @override
  List<Object?> get props => [movies, page, totalPages, totalResults];
}
