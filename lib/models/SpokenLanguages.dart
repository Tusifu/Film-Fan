// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'SpokenLanguages.g.dart';

@JsonSerializable()
class SpokenLanguage {
  late String name;
  late String? iso_639_1;

  SpokenLanguage({
    required this.name,
    this.iso_639_1,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> item) =>
      _$SpokenLanguageFromJson(item);
}
