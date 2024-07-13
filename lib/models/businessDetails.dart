import 'dart:convert';

class BusinessDetailsModel {
  List<String> specialization;
  String cityId;
  String radiusCoverage;
  String numberOfEmployees;
  String contactPersonName;
  String designationId;
  String websiteUrl;
  List social;

  BusinessDetailsModel({
    required this.specialization,
    required this.radiusCoverage,
    required this.cityId,
    required this.numberOfEmployees,
    required this.contactPersonName,
    required this.designationId,
    required this.websiteUrl,
    required this.social,
  });

  Map<String, dynamic> toMap() {
    return {
      'specialization': specialization,
      'radius_coverage': radiusCoverage,
      'city_id': cityId,
      'number_of_employees': numberOfEmployees,
      'contact_person_name': contactPersonName,
      'designation_id': designationId,
      'website_url': websiteUrl,
      'social': social.map((s) => s.toMap()).toList(),
    };
  }

  factory BusinessDetailsModel.fromMap(Map<String, dynamic> map) {
    return BusinessDetailsModel(
      specialization: List<String>.from(map['specialization']),
      radiusCoverage: map['radius_coverage'],
      cityId: map['city_id'],
      numberOfEmployees: map['number_of_employees'],
      contactPersonName: map['contact_person_name'],
      designationId: map['designation_id'],
      websiteUrl: map['website_url'],
      social: List<SocialMedia>.from(
          map['social'].map((x) => SocialMedia.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessDetailsModel.fromJson(String source) =>
      BusinessDetailsModel.fromMap(json.decode(source));
}

class SocialMedia {
  String name;
  String url;

  SocialMedia({
    required this.name,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory SocialMedia.fromMap(Map<String, dynamic> map) {
    return SocialMedia(
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialMedia.fromJson(String source) =>
      SocialMedia.fromMap(json.decode(source));
}
