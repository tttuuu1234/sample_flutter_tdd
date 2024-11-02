import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_tdd/core/client/api_client.dart';
import 'package:sample_flutter_tdd/features/github_repository/domain/github_repository_model.dart';

final githubRepoRepositoyProvider = Provider<GithubRepoRepository>((ref) {
  return GithubRepoRepository(ref.read(apiClientProvider));
});

class GithubRepoRepository {
  const GithubRepoRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<List<GitHubRepositoryModel>> search(String keyword) async {
    return await _apiClient.get(
      '/search/repositories',
      queryParameters: {'q': keyword},
    );
  }
}
