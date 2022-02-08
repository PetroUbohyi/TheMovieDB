import 'package:flutter/material.dart';
import 'package:themoviedb/presentation/movie_route_path.dart';

class MovieRouteInformationParser
    extends RouteInformationParser<MovieRoutePath> {
  @override
  Future<MovieRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.length >= 3) {
      var remaining = uri.pathSegments[1];
      return MovieRoutePath.castCrewList(
          int.tryParse(remaining), int.tryParse(remaining));
    } else if (uri.pathSegments.length == 2) {
      var remaining = uri.pathSegments[1];
      return MovieRoutePath.details(int.tryParse(remaining));
    } else {
      return MovieRoutePath.home();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(MovieRoutePath configuration) {
    if (configuration.isHomePage) {
      return const RouteInformation(location: '/');
    }
    if (configuration.isDetailsPage && !configuration.isActorsListPage) {
      return RouteInformation(location: '/movie/${configuration.id}');
    }
    if (configuration.isActorsListPage) {
      return RouteInformation(
          location: '/movie/${configuration.id}/castCrewList');
    }
    return null;
  }
}
