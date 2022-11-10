// ignore_for_file: file_names

import 'package:film_fan/models/ApiResponse.dart';
import 'package:film_fan/models/Movie.dart';
import 'package:film_fan/models/MovieDetail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MovieServices {
  // Constants
  String baseURL = dotenv.get('BASE_URL');
  String apiKeyValue = dotenv.get('API_KEY');
  String guestSessionIdValue = dotenv.get('GUEST_SESSION_ID');
  String languageValue = 'en-US';
  int page = 1;

  // Service to List all playing movies
  Future<APIResponse<List<Movie>>> getPlayingMovies() {
    var url = '$baseURL/now_playing';
    return Dio().get(
      url,
      queryParameters: {
        'api_key': apiKeyValue,
        'language': languageValue,
        'page': page,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        final jsonData = response.data;
        final movies = <Movie>[];
        for (var item in jsonData['results']) {
          movies.add(Movie.fromJson(item));
        }

        //sorting movies by alphabetic order
        movies.sort((a, b) => a.original_title
            .toLowerCase()
            .compareTo(b.original_title.toLowerCase()));
        return APIResponse<List<Movie>>(data: movies);
      } else {
        return APIResponse<List<Movie>>(
            error: true, errorMessage: response.data['status_message']);
      }
    }).catchError((error) {
      return APIResponse<List<Movie>>(
          error: true, errorMessage: "an Error occured");
    });
  }

  // Service to get the detail of movie

  Future<APIResponse<MovieDetail>> getMovieDetail(int movieId) {
    var url = '$baseURL/$movieId';
    return Dio().get(
      url,
      queryParameters: {
        'api_key': apiKeyValue,
        'language': languageValue,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        final jsonData = response.data;
        MovieDetail detail = MovieDetail.fromJson(jsonData);
        return APIResponse<MovieDetail>(data: detail);
      } else {
        return APIResponse<MovieDetail>(
            error: true, errorMessage: response.data['status_message']);
      }
    }).catchError((error) {
      return APIResponse<MovieDetail>(
          error: true, errorMessage: "an error occured");
    });
  }

  // Service to get similar movies of the passed id
  Future<APIResponse<List<Movie>>> getSimilar(int movieId) {
    var url = '$baseURL/$movieId/similar';
    return Dio().get(
      url,
      queryParameters: {
        'api_key': apiKeyValue,
        'language': languageValue,
        'page': page,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        final jsonData = response.data;
        final movies = <Movie>[];
        for (var item in jsonData['results']) {
          movies.add(Movie.fromJson(item));
        }
        return APIResponse<List<Movie>>(data: movies);
      } else {
        return APIResponse<List<Movie>>(
            error: true, errorMessage: response.data['status_message']);
      }
    }).catchError((error) {
      return APIResponse<List<Movie>>(
          error: true, errorMessage: "an error occured");
    });
  }

// Functiion to rate movie
  Future<APIResponse> rateMovie(int movieId, value) {
    var url = '$baseURL/$movieId/rating';
    var body = {'value': value};
    return Dio().post(
      url,
      data: body,
      queryParameters: {
        'api_key': apiKeyValue,
        'guest_session_id': guestSessionIdValue,
      },
    ).then((response) {
      if (response.statusCode == 201) {
        return APIResponse(data: response.data['status_message']);
      } else {
        return APIResponse(
            error: true, errorMessage: response.data['status_message']);
      }
    }).catchError((error) {
      return APIResponse(error: true, errorMessage: "an error occured");
    });
  }
}
