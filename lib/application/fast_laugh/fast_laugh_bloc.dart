import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_bloc/domain/core/failures/main_failure.dart';
import 'package:netflix_bloc/domain/downloads/i_downloads_repo.dart';
import 'package:netflix_bloc/domain/downloads/models/downloads.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final dummyVideoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"
];

ValueNotifier<Set<int>> likedVideosIdsNotifier = ValueNotifier({});

ValueNotifier<Set<int>> addMylistNotifier = ValueNotifier({});

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(
    IDownloadsRepo _downloadsRepo,
  ) : super(FastLaughState.initial()) {
    on<Initialize>((event, emit) async {
      emit(
          const FastLaughState(videoList: [], isLoading: true, isEroor: false));

      final _result = await _downloadsRepo.getDownloadsImage();

      final _state = _result.fold(
          (l) => const FastLaughState(
              videoList: [], isLoading: false, isEroor: true),
          (response) => FastLaughState(
              videoList: response, isLoading: false, isEroor: false));

      emit(_state);
    });

    // on<LikeVideo>((event, emit) async {
    //   likedVideosIdsNotifier.value.add(event.id);
    //   likedVideosIdsNotifier.notifyListeners();
    // });

    // on<UnLikeVideo>((event, emit) {
    //   likedVideosIdsNotifier.value.remove(event.id);
    //   likedVideosIdsNotifier.notifyListeners();
    // });
  }
}
