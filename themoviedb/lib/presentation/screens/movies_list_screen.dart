import 'package:flutter/material.dart';
import 'package:themoviedb/constants/strings.dart';
import 'package:themoviedb/data/models/movie.dart';

class MoviesListScreen extends StatelessWidget {
  const MoviesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movie = Movie(
        title: "Spider-Man",
        description:
        'Действие фильма «Человек-паук: Нет пути домой» начинает своё развитие в тот момент, когда Мистерио удаётся выяснить истинную личность Человека-паука. С этого момента жизнь Питера Паркера становится невыносимой. Если ранее он мог успешно переключаться между своими амплуа, то сейчас это сделать невозможно. Переворачивается с ног на голову не только жизнь Человека-пауку, но и репутация. Понимая, что так жить невозможно, главный герой фильма «Человек-паук: Нет пути домой» принимает решение обратиться за помощью к своему давнему знакомому Стивену Стрэнджу. Питер Паркер надеется, что с помощью магии он сможет восстановить его анонимность. Стрэндж соглашается помочь.',
        releaseDate: DateTime(5, 1, 2002));
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB'),
      ),
      body: Stack(
        children: [
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
                            Container(
                              width: 95,
                              color: Colors.red,
                            ),
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
                                    movie.title,
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '2.05.2021',
                                    style: TextStyle(color: Colors.grey),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    movie.description,
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
                            Navigator.of(context).pushNamed(
                                MOVIE_DETAILS_SCREEN);
                          },
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      )
                    ],
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: null,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withAlpha(235),
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
