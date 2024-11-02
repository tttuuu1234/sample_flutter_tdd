import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sample_flutter_tdd/features/github_repository/data/github_repo_repository.dart';
import 'package:sample_flutter_tdd/features/github_repository/domain/github_repository_model.dart';

class MockGitHubRepoRepository extends Mock implements GithubRepoRepository {}

void main() {
  test(
    '空の検索結果が返却されるはず。',
    () async {
      final mockRepository = MockGitHubRepoRepository();
      when(() => mockRepository.search('')).thenAnswer((_) async {
        return [];
      });

      final result = await mockRepository.search('');
      expect(result, isEmpty);
    },
  );

  test(
    '3件の検索結果が返却されるはず。',
    () async {
      final mockRepository = MockGitHubRepoRepository();
      when(() => mockRepository.search('Flutter')).thenAnswer((_) async {
        return [
          const GitHubRepositoryModel(id: 1, name: 'Flutter'),
          const GitHubRepositoryModel(id: 2, name: 'Flutter_Sample'),
          const GitHubRepositoryModel(id: 3, name: 'Flutter_Plactice'),
        ];
      });

      final result = await mockRepository.search('Flutter');
      expect(
        result,
        isA<List<GitHubRepositoryModel>>()
            .having((res) => res.length, '取得件数', 3)
            .having((res) => res[0].id, '一件目のid', 1)
            .having((res) => res[0].name, '一件目のname', 'Flutter'),
      );
    },
  );
}
