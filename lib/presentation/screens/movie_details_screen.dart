import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:themoviedb/data/api_client.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:themoviedb/data/models/credits.dart';
import 'package:themoviedb/data/models/movie.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie? movie;
  final ValueChanged<int> onTapped;

  const MovieDetailsScreen(
      {Key? key, required this.movie, required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MovieDetailCubit>(context).getDetailsMovie(movie!.id);

    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) {
      if (state is MovieDetailLoadingState) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text('Loading...'),
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (state is MovieDetailLoadedState) {
        final movieDetails = (state as MovieDetailLoadedState).movieDetails;
        final castAndCrew = (state as MovieDetailLoadedState).credits;
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(movieDetails.title),
          ),
          body: ListView(
            children: [
              _TopPosterWidget(
                backdropPath: movieDetails.backdropPath!,
                posterPath: movieDetails.posterPath!,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: _MovieTitleWidget(
                  movieTitle: movieDetails.title,
                  releaseDate: movieDetails.releaseDate!,
                ),
              ),
              _UserScoreWidget(
                voteAverage: movieDetails.voteAverage,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: _TaglineWidget(tagLine: movieDetails.tagline),
              ),
              _OverviewWidget(
                overview: movieDetails.overview!,
              ),
              SizedBox(
                height: 15,
              ),
              _TopBilledCastWidget(
                onTapped: onTapped,
                castAndCrew: castAndCrew,
                posterPath: movieDetails.posterPath!,
                movieId: movie!.id,
              ),
            ],
          ),
        );
      }
      return Center(
        child: Text("Error state"),
      );
    });
  }
}

class _TopPosterWidget extends StatelessWidget {
  final String backdropPath;
  final String posterPath;

  const _TopPosterWidget(
      {Key? key, required this.backdropPath, required this.posterPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 390.4 / 175.68,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Image.network(
            ApiClient.imageUrl(backdropPath),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            child: Image.network(ApiClient.imageUrl(posterPath)),
            top: 20,
            left: 20,
            bottom: 20,
          )
        ],
      ),
    );
  }
}

class _MovieTitleWidget extends StatelessWidget {
  final String movieTitle;
  final String releaseDate;

  const _MovieTitleWidget(
      {Key? key, required this.movieTitle, required this.releaseDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          maxLines: 3,
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: movieTitle,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' (${releaseDate.substring(0, 4)})',
                style: TextStyle(color: Colors.grey, fontSize: 18.5),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _UserScoreWidget extends StatelessWidget {
  final double voteAverage;

  const _UserScoreWidget({Key? key, required this.voteAverage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {},
            child: Row(
              children: [
                CircularPercentIndicator(
                  radius: 22.0,
                  lineWidth: 4.0,
                  percent: voteAverage / 10,
                  center: Text(
                    (voteAverage * 10).toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  progressColor: Colors.green,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'User Score',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            width: 1,
            height: 30,
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Play Trailer',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TaglineWidget extends StatelessWidget {
  final String? tagLine;

  const _TaglineWidget({Key? key, required this.tagLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      tagLine!,
      style: TextStyle(color: Colors.grey),
    );
  }
}

class _OverviewWidget extends StatelessWidget {
  final String overview;

  const _OverviewWidget({Key? key, required this.overview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            overview,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class _TopBilledCastWidget extends StatelessWidget {
  final String posterPath;
  final int movieId;
  final Credits castAndCrew;
  final ValueChanged<int> onTapped;

  const _TopBilledCastWidget(
      {Key? key,
      required this.posterPath,
      required this.movieId,
      required this.castAndCrew,
      required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cast = castAndCrew.cast;
    final isDark =
        Theme.of(context).iconTheme.color == Colors.white ? false : true;
    final colorBox = isDark ? Colors.grey.withOpacity(0.2) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ColoredBox(
        color: isDark ? Colors.black : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Top Billed Cast',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: textColor),
              ),
            ),
            SizedBox(
              height: 300,
              child: Scrollbar(
                child: ListView.builder(
                  itemExtent: 120,
                  itemCount: cast.length >= 10 ? 10 : cast.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final actor = cast[index];
                    final profilePath = actor.profilePath;
                    final name = actor.name;
                    final character = actor.character;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: colorBox,
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              profilePath != null
                                  ? FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: ApiClient.imageUrl(
                                          cast[index].profilePath!),
                                      height: 156,
                                    )
                                  // ? Image.network(
                                  //     ApiClient.imageUrl(
                                  //       cast[index].profilePath!,
                                  //     ),
                                  //     height: 156,
                                  //   )
                                  : Container(
                                      height: 156,
                                      child: Center(
                                        child: Text('No image'),
                                      ),
                                    ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: 13, color: textColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      character,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                      maxLines: 3,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: TextButton(
                onPressed: () {
                  onTapped(movieId);
                },
                child: Text(
                  "Full Cast & Crew",
                  style:
                      TextStyle(color: textColor, fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
