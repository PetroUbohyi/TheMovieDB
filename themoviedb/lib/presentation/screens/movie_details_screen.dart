import 'package:flutter/material.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movie title'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TopPosterWidget(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _MovieTitleWidget(),
            ),
          ],
        ));
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 370 / 190,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Image(
            image: AssetImage('assets/images/avengers.jpg'),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            child: Image(
              image: AssetImage('assets/images/spider_man.jpg'),
            ),
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
              text: 'Spider-Man',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
