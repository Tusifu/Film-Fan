// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'ProductionCompanies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionCompany _$ProductionCompanyFromJson(Map<String, dynamic> json) =>
    ProductionCompany(
      id: json['id'] as int,
      name: json['name'] as String,
      logo_path: json['logo_path'] as String?,
      origin_country: json['origin_country'] as String?,
    );

Map<String, dynamic> _$ProductionCompanyToJson(ProductionCompany instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo_path': instance.logo_path,
      'origin_country': instance.origin_country,
    };
