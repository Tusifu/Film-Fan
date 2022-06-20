// MODEL FOR FAVORITES, IT WILL BE USED TO STORE DATA IN LOCAL STORAGE WHICH IS
// SQLFLITE.

// ignore_for_file: non_constant_identifier_names, constant_identifier_names, prefer_const_declarations

final String tableFavorites = 'favorites';

class FavoriteFields {
  static final List<String> values = [
    /// Add all fields
    id, title, release_date, vote_average, movieId,
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String release_date = 'release_date';
  static const String vote_average = 'vote_average';
  static const String movieId = 'movieId';
  static const String poster_path = 'poster_path';
}

class Favorite {
  int? id;
  String? title;
  String? release_date;
  String? poster_path;
  String? vote_average;
  String? movieId;

  Favorite({
    this.id,
    this.title,
    this.release_date,
    this.vote_average,
    this.movieId,
    this.poster_path,
  });

  Favorite copy({
    required int id,
    required String title,
    required String release_date,
    required String poster_path,
    required String vote_average,
    required String movieId,
  }) =>
      Favorite(
        id: id,
        title: title,
        release_date: release_date,
        vote_average: vote_average,
        movieId: movieId,
        poster_path: poster_path,
      );

  static Favorite fromJson(Map<String, Object?> json) => Favorite(
        id: json[FavoriteFields.id] as int,
        title: json[FavoriteFields.title] as String,
        release_date: json[FavoriteFields.release_date] as String,
        vote_average: json[FavoriteFields.vote_average] as String,
        movieId: json[FavoriteFields.movieId] as String,
        poster_path: json[FavoriteFields.poster_path] as String,
      );

  Map<String, Object?> toJson() => {
        FavoriteFields.id: id,
        FavoriteFields.movieId: movieId,
        FavoriteFields.title: title,
        FavoriteFields.release_date: release_date,
        FavoriteFields.vote_average: vote_average,
        FavoriteFields.poster_path: poster_path,
      };
}
