import 'package:dartz/dartz.dart';
import 'package:netflix_bloc/domain/core/failures/main_failure.dart';
import 'package:netflix_bloc/domain/hot_and_new/model/hot_and_new/hot_and_new.dart';

abstract class HotAndNewRepoServices {
  Future<Either<MainFailure, HotAndNewResponse>> getMoviesData();
  Future<Either<MainFailure, HotAndNewResponse>> getTvshows();
}
