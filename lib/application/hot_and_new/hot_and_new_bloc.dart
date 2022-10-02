import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_bloc/domain/core/failures/main_failure.dart';
import 'package:netflix_bloc/domain/hot_and_new/hot_and_new_repo.dart';
import 'package:netflix_bloc/domain/hot_and_new/model/hot_and_new/hot_and_new.dart';
import 'package:netflix_bloc/infrastructure/hot_and_new/hot_and_new_repository.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewRepoServices hotAndNewRepoServices;
  HotAndNewBloc({required this.hotAndNewRepoServices})
      : super(HotAndNewState.initial()) {
    on<LoadDataInComingSoon>((event, emit) async {
      emit(const HotAndNewState(
          comingSoonList: [],
          evryonesWatchList: [],
          isLoading: true,
          hasError: false));
      final _result = await hotAndNewRepoServices.getMoviesData();

      final _state = _result.fold((MainFailure failure) {
        return const HotAndNewState(
            comingSoonList: [],
            evryonesWatchList: [],
            isLoading: false,
            hasError: true);
      }, (HotAndNewResponse response) {
        return HotAndNewState(
            comingSoonList: response.results,
            evryonesWatchList: [],
            isLoading: false,
            hasError: false);
      });

      emit(_state);
    });

    on<LoadDataInEveryonesWatching>((event, emit) async {
      emit(const HotAndNewState(
          comingSoonList: [],
          evryonesWatchList: [],
          isLoading: true,
          hasError: false));

      final _result = await hotAndNewRepoServices.getTvshows();

      final _state = _result.fold((MainFailure failure) {
        return const HotAndNewState(
            comingSoonList: [],
            evryonesWatchList: [],
            isLoading: false,
            hasError: true);
      }, (HotAndNewResponse response) {
        return HotAndNewState(
            comingSoonList: [],
            evryonesWatchList: response.results,
            isLoading: false,
            hasError: false);
      });

      emit(_state);
    });
  }
}
