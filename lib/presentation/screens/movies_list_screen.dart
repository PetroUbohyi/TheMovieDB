import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/constants/strings.dart';
import 'package:themoviedb/cubit/movies/movies_cubit.dart';
import 'package:themoviedb/data/api_client.dart';
import 'package:themoviedb/theme/app_colors.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({Key? key}) : super(key: key);

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  var filter = 'top_rated';

  @override
  void initState() {
    BlocProvider.of<MoviesCubit>(context).loadMovies(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB'),
        actions: [
          DropdownButton(
              dropdownColor: AppColors.mainAppColor,
              value: filter == 'popular' ? 'Popular' : 'Top Rated',
              style: TextStyle(color: Colors.white),
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
                  BlocProvider.of<MoviesCubit>(context).filterSelected(filter);
                });
              }),
        ],
      ),
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MoviesLoadedState) {
            final movies = (state as MoviesLoadedState).movies;
            final isDark = Theme.of(context).iconTheme.color == Colors.white
                ? false
                : true;
            final textColor = isDark ? Colors.white : Colors.black;
            return Stack(
              children: [
                ListView.builder(
                    padding: EdgeInsets.only(top: 70),
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
                                    color: Colors.black.withOpacity(0.2)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Row(
                                children: [
                                  posterPath != null
                                      ? Image.network(
                                          ApiClient.imageUrl(posterPath),
                                          width: 118.7,
                                        )
                                      : SizedBox.shrink(),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
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
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          movie.releaseDate!,
                                          style: TextStyle(color: Colors.grey),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
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
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  final id = movie.id;
                                  Navigator.of(context).pushNamed(
                                      MOVIE_DETAILS_SCREEN,
                                      arguments: id);
                                },
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withAlpha(235),
                      border: OutlineInputBorder(),
                      labelText: 'Search',
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Text('ERROR STATE'),
          );
        },
      ),
    );
  }
}

/*
ListView.builder(
              padding: EdgeInsets.only(top: 70),
              itemCount: 10,
              itemExtent: 200,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.black.withOpacity(0.2)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Row(
                          children: [
                            Image(
                                image:
                                    AssetImage('assets/images/spider_man.jpg')),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    title,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    releaseDate,
                                    style: TextStyle(color: Colors.grey),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    description,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(MOVIE_DETAILS_SCREEN);
                          },
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      )
                    ],
                  ),
                );
              });
 */
