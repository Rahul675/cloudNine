import 'package:get/get.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String phone_number;
  final String? email_verified_at;
  final String? phone_verified_at;
  final Map? users_business;
  final Map users_business_details;
  List? users_business_licences;
  List users_business_ids;
  List users_business_shop_photo;
  final List users_business_specialization;
  final List users_business_social_details;
  final String? login_at;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone_number,
    this.email_verified_at,
    this.phone_verified_at,
    this.users_business,
    required this.users_business_details,
    required this.users_business_licences,
    required this.users_business_ids,
    required this.users_business_shop_photo,
    required this.users_business_specialization,
    required this.users_business_social_details,
    this.login_at,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone_number: json['phone_number'],
      email_verified_at: json['email_verified_at'],
      phone_verified_at: json['phone_verified_at'],
      users_business: json['users_business'],
      users_business_details: json['users_business_details'],
      users_business_licences: json['users_business_licences'],
      users_business_ids: json['users_business_ids'],
      users_business_shop_photo: json['users_business_shop_photo'],
      users_business_specialization: json['users_business_specialization'],
      users_business_social_details: json['users_business_social_details'],
      login_at: json['login_at'],
    );
  }

  
}
