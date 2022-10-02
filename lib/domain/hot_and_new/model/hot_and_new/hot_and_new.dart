import 'package:json_annotation/json_annotation.dart';

part 'hot_and_new.g.dart';

@JsonSerializable()
class HotAndNewResponse {
  int? page;
  @JsonKey(name: 'results')
  List<HotAndNewData> results;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  HotAndNewResponse(
      {this.page, this.results = const [], this.totalPages, this.totalResults});

  factory HotAndNewResponse.fromJson(Map<String, dynamic> json) {
    return _$HotAndNewResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HotAndNewResponseToJson(this);
}

@JsonSerializable()
class HotAndNewData {
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'original_title')
  String? originalTitle;
  @JsonKey(name: 'overview')
  String? overview;

  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'release_date')
  String? releaseDate;
  @JsonKey(name: 'title')
  String? title;

  HotAndNewData({
    this.backdropPath,
    this.id,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
  });

  factory HotAndNewData.fromJson(Map<String, dynamic> json) {
    return _$HotAndNewDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HotAndNewDataToJson(this);
}
