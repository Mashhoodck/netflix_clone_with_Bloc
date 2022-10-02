import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_bloc/domain/search/models/search_response/search_response.dart';

import 'package:netflix_bloc/domain/core/failures/main_failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/core/api_end_ponits.dart';
import '../../domain/search/i_serch_service_repo.dart';

@LazySingleton(as: IsearchSearviceRepo)
class SearchRepository implements IsearchSearviceRepo {
  @override
  Future<Either<MainFailure, SearchResponse>> searchMovies(
      {required String movieQuery}) async {
    try {
      final response = await Dio(BaseOptions())
          .get(ApiEndPoints.search, queryParameters: {'query': movieQuery});
      log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = SearchResponse.fromJson(response.data);

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
