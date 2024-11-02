import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_repository_model.freezed.dart';
part 'github_repository_model.g.dart';

@freezed
class GitHubRepositoryModel with _$GitHubRepositoryModel {
  const factory GitHubRepositoryModel({
    required int id,
    required String name,
  }) = _GitHubRepositoryModel;

  factory GitHubRepositoryModel.fromJson(Map<String, dynamic> json) =>
      _$GitHubRepositoryModelFromJson(json);
}
