import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_tdd/features/github_repository/data/github_repo_repository.dart';
import 'package:sample_flutter_tdd/features/github_repository/domain/github_repository_model.dart';

final githubRepositorySearchUsecaseProvider = AsyncNotifierProvider<
    GithubRepositorySearchUsecase,
    List<GitHubRepositoryModel>>(GithubRepositorySearchUsecase.new);

class GithubRepositorySearchUsecase
    extends AsyncNotifier<List<GitHubRepositoryModel>> {
  @override
  FutureOr<List<GitHubRepositoryModel>> build() async {
    return [];
  }

  Future<void> run(String keyword) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final res = await ref.read(githubRepoRepositoyProvider).search(keyword);
      return res;
    });
  }
}
