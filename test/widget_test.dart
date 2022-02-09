import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:themoviedb/presentation/screens/movies_list_screen.dart';

void main() {
  testWidgets('Movies List Screen Test', (tester) async {
    await tester.pumpWidget(MoviesListScreen(onTapped: (_) {}));
    expect(find.byType(AppBar), findsOneWidget);
  });
}
