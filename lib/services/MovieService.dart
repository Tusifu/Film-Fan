import 'dart:convert';

import 'package:film_fan/models/ApiResponse.dart';
import 'package:film_fan/models/Movie.dart';
import 'package:film_fan/models/MovieDetail.dart';
import 'package:http/http.dart' as http;

class MovieServices {
  String apiKey = 'd233e5fad5d2f4377e066ff36ed709f2';
  Future<APIResponse<List<Movie>>> getPlayingMovies() {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=en-US&page=1');
    return http.get(url).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
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
            error: true, errorMessage: 'an Error Occured');
      }
    }).catchError((error) {
      return APIResponse<List<Movie>>(error: true, errorMessage: error);
    });
  }

  // method to get the detail of movie

  Future<APIResponse<MovieDetail>> getMovieDetail(int movieId) {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey&language=en-US');
    return http.get(url).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        MovieDetail detail = MovieDetail.fromJson(jsonData);
        return APIResponse<MovieDetail>(data: detail);
      } else {
        return APIResponse<MovieDetail>(
            error: true, errorMessage: 'an Error Occured');
      }
    }).catchError((error) {
      print(error);
      return APIResponse<MovieDetail>(
          error: true, errorMessage: "an error occured");
    });
  }
}
