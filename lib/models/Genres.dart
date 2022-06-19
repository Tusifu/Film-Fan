import 'package:json_annotation/json_annotation.dart';

part 'Genres.g.dart';

@JsonSerializable()
class Genres {
  late int id;
  late String name;

  Genres({required this.id, required this.name});

  factory Genres.fromJson(Map<String, dynamic> item) => _$GenresFromJson(item);
}
