import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_bloc/domain/hot_and_new/hot_and_new_repo.dart';

import '../../domain/hot_and_new/model/hot_and_new/hot_and_new.dart';

part 'homebloc_event.dart';
part 'homebloc_state.dart';
part 'homebloc_bloc.freezed.dart';

@injectable
class HomeblocBloc extends Bloc<HomeblocEvent, HomeblocState> {
  final HotAndNewRepoServices _hotAndNewRepoServices;
  HomeblocBloc(this._hotAndNewRepoServices) : super(HomeblocState.initial()) {
    //

//
    on<GetHomeScreenData>(
      (event, emit) async {
        emit(const HomeblocState(
            stateId: "0",
            pastYearMovieList: [],
            trendingMovieList: [],
            tensDramaMovieList: [],
            southMovieList: [],
            trendingTvList: [],
            isLoading: true,
            isError: false));

        final _movieResult = await _hotAndNewRepoServices.getMoviesData();

        final _tvResult = await _hotAndNewRepoServices.getTvshows();

        final state1 = _movieResult.fold((l) {
          return HomeblocState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingMovieList: [],
            tensDramaMovieList: [],
            southMovieList: [],
            trendingTvList: [],
            isLoading: false,
            isError: true,
          );
        }, (response) {
          //makeList before shuffle
          final pastyear = response.results;
          final trendingMovie = response.results;
          final tensDrama = response.results;
          final southIndian = response.results;
          final trendingTV = response.results;

          //shuffle all list
          pastyear.shuffle();
          trendingMovie.shuffle();
          tensDrama.shuffle();
          southIndian.shuffle();
          trendingTV.shuffle();

          return HomeblocState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: pastyear,
              trendingMovieList: trendingMovie,
              tensDramaMovieList: tensDrama,
              southMovieList: southIndian,
              trendingTvList: state.trendingTvList,
              isLoading: false,
              isError: true);
        });
        emit(state1);

        final state2 = _tvResult.fold((l) {
          return HomeblocState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: [],
              trendingMovieList: [],
              tensDramaMovieList: [],
              southMovieList: [],
              trendingTvList: [],
              isLoading: false,
              isError: true);
        }, (response) {
          final top10MovieList = response.results;

          return HomeblocState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovieList: state.pastYearMovieList,
              trendingMovieList: state.trendingMovieList,
              tensDramaMovieList: state.tensDramaMovieList,
              southMovieList: state.southMovieList,
              trendingTvList: top10MovieList,
              isLoading: false,
              isError: true);
        });

        emit(state2);
      },
    );
  }
}
