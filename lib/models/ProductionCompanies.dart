// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'ProductionCompanies.g.dart';

@JsonSerializable()
class ProductionCompany {
  late int id;
  late String name;
  late String? logo_path;
  late String? origin_country;

  ProductionCompany(
      {required this.id,
      required this.name,
      this.logo_path,
      this.origin_country});

  factory ProductionCompany.fromJson(Map<String, dynamic> item) =>
      _$ProductionCompanyFromJson(item);
}
