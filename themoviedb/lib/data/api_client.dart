import 'dart:convert';
import 'dart:io';

import 'package:themoviedb/data/models/movie_response.dart';

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _apiKey = '2913a7cd055791a93a885f2e5f37e684';

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> _get<T>(String path, T Function(dynamic json) parser,
      [Map<String, dynamic>? parameters]) async {
    final url = _makeUri(path, parameters);
    final request = await _client.getUrl(url);
    final response = await request.close();
    final dynamic json = (await response.jsonDecode());
    final result = parser(json);
    return result;
  }

  Future<MovieResponse> fetchMovie(int page) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieResponse.fromJson(jsonMap);
      return response;
    };
    final result = _get(
      'movie/popular',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'page': page.toString(),
      },
    );
    return result;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder).toList().then((value) {
      final result = value.join();
      return result;
    }).then<dynamic>((value) => json.decode(value));
  }
}
