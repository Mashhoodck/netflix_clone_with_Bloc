import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_bloc/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix_bloc/domain/hot_and_new/hot_and_new_repo.dart';
import 'package:netflix_bloc/domain/hot_and_new/model/hot_and_new/hot_and_new.dart';
import '../../domain/core/api_end_ponits.dart';

@LazySingleton(as: HotAndNewRepoServices)
class HotAndNewRepository extends HotAndNewRepoServices {
  @override
  Future<Either<MainFailure, HotAndNewResponse>> getMoviesData() async {
    try {
      final response = await Dio(BaseOptions()).get(ApiEndPoints.hotAndNewTv);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotAndNewResponse.fromJson(response.data);

        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, HotAndNewResponse>> getTvshows() async {
    try {
      final response =
          await Dio(BaseOptions()).get(ApiEndPoints.hotAndNewMovie);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotAndNewResponse.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
