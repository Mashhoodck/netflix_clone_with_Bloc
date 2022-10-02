import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_bloc/domain/core/failures/main_failure.dart';
import 'package:netflix_bloc/domain/downloads/i_downloads_repo.dart';
import 'package:netflix_bloc/domain/search/i_serch_service_repo.dart';
import 'package:netflix_bloc/infrastructure/search/search_repository.dart';

import '../../domain/downloads/models/downloads.dart';
import '../../domain/search/models/search_response/search_response.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRepo _downloadsRepo;
  final IsearchSearviceRepo _searchRepository;
  SearchBloc(this._downloadsRepo, this._searchRepository)
      : super(SearchState.initial()) {
    on<Initialize>((event, emit) async {
      //here is the initial stage get trending and show to Ui

      // this code will exicute ones value already loaded in screen

      if (state.idleList.isNotEmpty) {
        emit(SearchState(
            searchResultList: [],
            idleList: state.idleList,
            isLoading: false,
            isError: false));

        return;
      }

      emit(const SearchState(
          searchResultList: [], idleList: [], isLoading: true, isError: false));

      final _result = await _downloadsRepo.getDownloadsImage();

      final _state = _result.fold((MainFailure failure) {
        return const SearchState(
            searchResultList: [],
            idleList: [],
            isLoading: false,
            isError: true);
      }, (List<Downloads> list) {
        return SearchState(
            searchResultList: [],
            idleList: list,
            isLoading: false,
            isError: false);
      });

      emit(_state);
    });
    on<SearchMovie>((event, emit) async {
      // call search movie api AND SHOW UI

      emit(const SearchState(
          searchResultList: [], idleList: [], isLoading: true, isError: false));

      final _result =
          await _searchRepository.searchMovies(movieQuery: event.movieQuery);

      final _state = _result.fold((MainFailure failure) {
        return const SearchState(
            searchResultList: [],
            idleList: [],
            isLoading: false,
            isError: true);
      }, (SearchResponse response) {
        return SearchState(
            searchResultList: response.searchresults,
            idleList: [],
            isLoading: false,
            isError: true);
      });

      emit(_state);
    });
  }
}
