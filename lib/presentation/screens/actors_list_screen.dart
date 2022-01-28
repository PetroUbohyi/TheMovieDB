import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/cubit/cast_crew/cast_crew_cubit.dart';
import 'package:themoviedb/data/api_client.dart';

class ActorsListScreen extends StatelessWidget {
  final int movieId;

  const ActorsListScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CastCrewCubit>(context).fetchCastCrew(movieId);
    return BlocBuilder<CastCrewCubit, CastCrewState>(builder: (context, state) {
      if (state is CastCrewLoadingState) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
          appBar: AppBar(
            title: Text(
              "Full Cast & Crew",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        );
      }
      if (state is CastCrewLoadedState) {
        final castCrewList = (state as CastCrewLoadedState).castCrewUI;
        final isDark =
            Theme.of(context).iconTheme.color == Colors.white ? false : true;
        final colorBox = isDark ? Colors.grey.withOpacity(0.2) : Colors.white;
        final textColor = isDark ? Colors.white : Colors.black;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Full Cast & Crew",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          body: ListView.builder(
            itemCount: castCrewList.length,
            itemExtent: 200,
            itemBuilder: (BuildContext context, int index) {
              final person = castCrewList[index];
              final profilePath = person.profilePath;
              final name = person.name;
              final characterOrDepartment = person.characterOrDepartment;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Stack(
                  children: [
                    Container(
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
                                    child: Text(
                                      'No image',
                                      style: TextStyle(color: textColor),
                                    ),
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
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: textColor),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  characterOrDepartment,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
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
            },
          ),
        );
      }
      return Center(child: Text('ERROR STATE'));
    });
  }
}
