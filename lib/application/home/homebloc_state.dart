part of 'homebloc_bloc.dart';

@freezed
class HomeblocState with _$HomeblocState {
  const factory HomeblocState(
      {required String stateId,
      required List<HotAndNewData> pastYearMovieList,
      required List<HotAndNewData> trendingMovieList,
      required List<HotAndNewData> tensDramaMovieList,
      required List<HotAndNewData> southMovieList,
      required List<HotAndNewData> trendingTvList,
      required bool isLoading,
      required bool isError}) = _Initial;

  factory HomeblocState.initial() => const HomeblocState(
      stateId: "0",
      pastYearMovieList: [],
      trendingMovieList: [],
      tensDramaMovieList: [],
      southMovieList: [],
      trendingTvList: [],
      isLoading: false,
      isError: false);
}
