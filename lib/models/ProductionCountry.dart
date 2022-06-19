// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'ProductionCountry.g.dart';

@JsonSerializable()
class ProductionCountry {
  late String name;
  late String? iso_3166_1;

  ProductionCountry({
    required this.name,
    this.iso_3166_1,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> item) =>
      _$ProductionCountryFromJson(item);
}
