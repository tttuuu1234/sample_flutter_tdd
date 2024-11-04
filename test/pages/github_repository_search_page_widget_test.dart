import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_flutter_tdd/pages/github_repository_search_page.dart';

import '../flutter_test_helper.dart';

void main() {
  group('初期表示', () {
    testWidgets(
      '検索フィールドが表示されているはず。',
      (tester) async {
        final app = testableApp(const GithubRepositorySearchPage());
        runApp(app);
        await tester.pumpAndSettle();
        final searchBarType = find.byType(SearchBar);

        expect(searchBarType, findsOneWidget);
      },
    );

    testWidgets(
      '検索フィールドには何も入力されていないはず。',
      (tester) async {
        final app = testableApp(const GithubRepositorySearchPage());
        runApp(app);
        await tester.pumpAndSettle();
        final searchBarType = find.byType(SearchBar);
        final searchBar = searchBarType.evaluate().single.widget as SearchBar;

        expect(searchBar.controller!.text, isEmpty);
      },
    );
  });
}
