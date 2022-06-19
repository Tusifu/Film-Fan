import 'package:film_fan/models/Genres.dart';
import 'package:film_fan/models/ProductionCompanies.dart';
import 'package:film_fan/models/ProductionCountry.dart';
import 'package:film_fan/models/SpokenLanguages.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MovieDetail.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetail {
  late bool adult;
  late String poster_path;
  late String overview;
  late String release_date;
  late List<Genres> genres;
  late int id;
  late String original_title;
  late String original_language;
  late String title;
  late String backdrop_path;
  late num popularity;
  late int vote_count;
  late bool video;
  late num vote_average;
  late dynamic belongs_to_collection;
  late int budget;
  late String homepage;
  late String imdb_id;
  late List<ProductionCompany> production_companies;
  late List<ProductionCountry> production_countries;
  late int revenue;
  late int runtime;
  late List<SpokenLanguage> spoken_languages;
  late String status;
  late String tagline;

  MovieDetail({
    required this.poster_path,
    required this.adult,
    required this.overview,
    required this.release_date,
    required this.genres,
    required this.id,
    required this.original_title,
    required this.original_language,
    required this.title,
    required this.backdrop_path,
    required this.popularity,
    required this.vote_count,
    required this.video,
    required this.vote_average,
    required this.belongs_to_collection,
    required this.budget,
    required this.homepage,
    required this.imdb_id,
    required this.production_companies,
    required this.production_countries,
    required this.revenue,
    required this.runtime,
    required this.spoken_languages,
    required this.status,
    required this.tagline,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> item) =>
      _$MovieDetailFromJson(item);
}
