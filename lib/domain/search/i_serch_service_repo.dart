import 'package:dartz/dartz.dart';
import 'package:netflix_bloc/domain/core/failures/main_failure.dart';
import 'package:netflix_bloc/domain/search/models/search_response/search_response.dart';

abstract class IsearchSearviceRepo {
  Future<Either<MainFailure, SearchResponse>> searchMovies(
      {required String movieQuery});
}
