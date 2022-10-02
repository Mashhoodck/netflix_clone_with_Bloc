import 'package:netflix_bloc/core/strings.dart';
import 'package:netflix_bloc/infrastructure/api_key.dart';

class ApiEndPoints {
  static const downloads = "$kBaseUrl/trending/all/day?api_key=$apiKey";

  static const search = "$kBaseUrl/search/movie?api_key=$apiKey";

  static const hotAndNewMovie = "$kBaseUrl/discover/movie?api_key=$apiKey";
  static const hotAndNewTv = "$kBaseUrl/discover/tv?api_key=$apiKey";

  static const trending = '$kBaseUrl/trending/all/day?api_key=$apiKey';
}
