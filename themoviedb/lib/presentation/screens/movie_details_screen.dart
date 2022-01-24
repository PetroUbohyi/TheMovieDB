import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/cubit/movie_detail_cubit.dart';
import 'package:themoviedb/data/api_client.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MovieDetailCubit>(context).getDetailsMovie(movieId);

    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) {
      if (state is MovieDetailLoadingState) {
        return Scaffold(
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

        return Scaffold(
          appBar: AppBar(
            title: Text(movieDetails.title),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopPosterWidget(
                backdropPath: movieDetails.backdropPath!,
                posterPath: movieDetails.posterPath!,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: _MovieTitleWidget(),
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
      aspectRatio: 370 / 190,
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
  const _MovieTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          maxLines: 3,
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                  text: 'Spider-Man',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
