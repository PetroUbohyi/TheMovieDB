import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart' as dio;
import 'package:mockito/mockito.dart';

import 'movie_repository_test.mocks.dart';

@GenerateMocks([dio.Dio])
void main() {
  test('demo', () async {
    final mockDio = MockDio();

  });
}
