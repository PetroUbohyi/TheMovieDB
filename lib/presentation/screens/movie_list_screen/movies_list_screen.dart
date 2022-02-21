import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/data/models/movie_model/movie_ui.dart';
import 'package:themoviedb/data/networking/movie_repository.dart';
import 'package:themoviedb/theme/app_colors.dart';

import 'movies_list_cubit/movies_cubit.dart';

class MoviesListScreen extends StatefulWidget {
  final ValueChanged<MovieUIModel> onTapped;

  const MoviesListScreen({Key? key, required this.onTapped}) : super(key: key);

  @override
  State<MoviesListScreen> createState() =>
      _MoviesListScreenState(onTapped: onTapped);
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  var filter = 'top_rated';
  final ValueChanged<MovieUIModel> onTapped;

  _MoviesListScreenState({required this.onTapped});

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesCubit>(context).loadMovies(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TheMovieDB'),
        actions: [
          DropdownButton(
              dropdownColor: AppColors.mainAppColor,
              value: filter == 'popular' ? 'Popular' : 'Top Rated',
              style: const TextStyle(color: Colors.white),
              elevation: 16,
              items: <String>['Popular', 'Top Rated']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(
                  child: Text(
                    value,
                  ),
                  value: value,
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  filter = newValue! == "Popular" ? 'popular' : 'top_rated';
                  BlocProvider.of<MoviesCubit>(context).resetList(filter);
                });
              }),
        ],
      ),
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MoviesLoadedState) {
            final movies = state.movies;
            final isDark = Theme.of(context).iconTheme.color == Colors.white
                ? false
                : true;
            final textColor = isDark ? Colors.white : Colors.black;
            return Stack(
              children: [
                ListView.builder(
                    padding: const EdgeInsets.only(top: 70),
                    itemCount: movies.length,
                    itemExtent: 200,
                    itemBuilder: (BuildContext context, int index) {
                      BlocProvider.of<MoviesCubit>(context)
                          .showedMovieAtIndex(index, filter);
                      final movie = movies[index];
                      final posterPath = movie.posterPath;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).iconTheme.color,
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Row(
                                children: [
                                  posterPath != null
                                      ? Image.network(
                                          MovieRepository.imageUrl(posterPath),
                                          width: 118.7,
                                        )
                                      : const SizedBox.shrink(),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          movie.title,
                                          style: TextStyle(
                                              color: textColor,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          movie.releaseDate != null
                                              ? movie.releaseDate!
                                              : '',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          movie.overview,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: textColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  onTapped(movie);
                                },
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    key: const ValueKey('searchTextField'),
                    onChanged:
                        BlocProvider.of<MoviesCubit>(context).searchMovie,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withAlpha(235),
                      border: const OutlineInputBorder(),
                      labelText: 'Search',
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Text('ERROR STATE'),
          );
        },
      ),
    );
  }
}
