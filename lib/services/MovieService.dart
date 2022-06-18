import 'dart:convert';

import 'package:ayumutekano/models/ApiResponse.dart';
import 'package:ayumutekano/models/Movie.dart';
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

        for (var item in jsonData) {
          movies.add(Movie.fromJson(item));
        }
        return APIResponse<List<Movie>>(data: movies);
      } else {
        return APIResponse<List<Movie>>(
            error: true, errorMessage: 'an Error Occured');
      }
    }).catchError((error) {
      return APIResponse<List<Movie>>(error: true, errorMessage: error);
    });
  }
}
