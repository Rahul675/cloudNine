class RegistrationRequest {
  String name;
  String email;
  String password;
  String businessTypeId;
  String businessDate;
  String businessAddressLine1;
  String businessAddressLine2;
  String cityId;
  String zipCode;
  String phoneNumber;
  String confirmPassword;

  RegistrationRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.businessTypeId,
    required this.businessDate,
    required this.businessAddressLine1,
    required this.businessAddressLine2,
    required this.cityId,
    required this.zipCode,
    required this.phoneNumber,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'business_type_id': businessTypeId,
      'business_date': businessDate,
      'business_address_line1': businessAddressLine1,
      'business_address_line2': businessAddressLine2,
      'city_id': cityId,
      'zip_code': zipCode,
      'phone_number': phoneNumber,
      'confirm_password': confirmPassword,
    };
  }
}
