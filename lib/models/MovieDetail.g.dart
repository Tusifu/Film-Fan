// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MovieDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetail _$MovieDetailFromJson(Map<String, dynamic> json) => MovieDetail(
      poster_path: json['poster_path'] as String,
      adult: json['adult'] as bool,
      overview: json['overview'] as String,
      release_date: json['release_date'] as String,
      genres: (json['genres'] as List<dynamic>)
          .map((e) => Genres.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int,
      original_title: json['original_title'] as String,
      original_language: json['original_language'] as String,
      title: json['title'] as String,
      backdrop_path: json['backdrop_path'] as String,
      popularity: json['popularity'] as num,
      vote_count: json['vote_count'] as int,
      video: json['video'] as bool,
      vote_average: json['vote_average'] as num,
      belongs_to_collection: json['belongs_to_collection'],
      budget: json['budget'] as int,
      homepage: json['homepage'] as String,
      imdb_id: json['imdb_id'] as String,
      production_companies: (json['production_companies'] as List<dynamic>)
          .map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
      production_countries: (json['production_countries'] as List<dynamic>)
          .map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
          .toList(),
      revenue: json['revenue'] as int,
      runtime: json['runtime'] as int,
      spoken_languages: (json['spoken_languages'] as List<dynamic>)
          .map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      tagline: json['tagline'] as String,
    );
