import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_flutter_tdd/pages/github_repository_search_page.dart';

void main() {
  testWidgets(
    '初期表示は画面に検索フィールドが何も入力されていない状態で表示されているはず。',
    (tester) async {
      const app = ProviderScope(
        child: MaterialApp(
          home: GithubRepositorySearchPage(),
        ),
      );
      runApp(app);
      await tester.pumpAndSettle();
      final searchBarType = find.byType(SearchBar);
      final searchBar = searchBarType.evaluate().single.widget as SearchBar;

      expect(searchBarType, findsOneWidget);
      expect(searchBar.controller!.text, isEmpty);
    },
  );
}
