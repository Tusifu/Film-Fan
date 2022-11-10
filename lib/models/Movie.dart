// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'Movie.g.dart';

@JsonSerializable()
class Movie {
  late String poster_path;
  late bool adult;
  late String overview;
  late String release_date;
  late List genre_ids;
  late int id;
  late String original_title;
  late String original_language;
  late String title;
  late String backdrop_path;
  late num popularity;
  late int vote_count;
  late bool video;
  late num vote_average;

  Movie({
    required this.poster_path,
    required this.adult,
    required this.overview,
    required this.release_date,
    required this.genre_ids,
    required this.id,
    required this.original_title,
    required this.original_language,
    required this.title,
    required this.backdrop_path,
    required this.popularity,
    required this.vote_count,
    required this.video,
    required this.vote_average,
  });

  factory Movie.fromJson(Map<String, dynamic> item) => _$MovieFromJson(item);
}
