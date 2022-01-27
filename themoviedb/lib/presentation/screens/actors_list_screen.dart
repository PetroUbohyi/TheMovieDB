import 'package:flutter/material.dart';
import 'package:themoviedb/data/api_client.dart';
import 'package:themoviedb/data/models/credits.dart';

class ActorsListScreen extends StatelessWidget {
  final Credits credits;

  const ActorsListScreen({Key? key, required this.credits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Full Cast & Crew",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 20, bottom: 10),
            child: Row(
              children: [
                Text(
                  'Cast',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '${credits.cast.length}',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListCrewWidget(credits: credits),
          ),
        ],
      ),
    );
  }
}

class ListCrewWidget extends StatelessWidget {
  const ListCrewWidget({
    Key? key,
    required this.credits,
  }) : super(key: key);

  final Credits credits;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: credits.cast.length + credits.crew.length,
        itemExtent: 200,
        itemBuilder: (BuildContext context, int index) {
          final person = index < credits.cast.length
              ? credits.cast[index]
              : credits.crew[index];
          final profilePath = '';
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
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
                      // profilePath != null
                      //     ? Image.network(
                      //         ApiClient.imageUrl(index > credits.cast.length
                      //             ? profilePathCast!
                      //             : profilePathCrew!),
                      //         width: 118.7,
                      //       )
                      //     : Container(
                      //         child: Center(
                      //           child: Text('No image'),
                      //         ),
                      //         width: 118.7,
                      //       ),
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
                              'name',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'department',
                              style: TextStyle(color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class ListCastWidget extends StatelessWidget {
  const ListCastWidget({
    Key? key,
    required this.casts,
  }) : super(key: key);

  final List<Cast> casts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: casts.length,
        itemExtent: 200,
        itemBuilder: (BuildContext context, int index) {
          final cast = casts[index];
          final profilePath = cast.profilePath;
          final name = cast.name;
          final character = cast.character;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
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
                      profilePath != null
                          ? Image.network(
                              ApiClient.imageUrl(profilePath),
                              width: 118.7,
                            )
                          : Container(
                              child: Center(
                                child: Text('No image'),
                              ),
                              width: 118.7,
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
                              name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              character,
                              style: TextStyle(color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
