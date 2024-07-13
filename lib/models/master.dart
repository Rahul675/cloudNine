class Master {
  final List business_types;
  final List designation;
  final List specialization;
  final List state;
  List city;

  Master({
    required this.business_types,
    required this.designation,
    required this.specialization,
    required this.state,
    required this.city,
  });

  factory Master.fromJson(Map<String, dynamic> json) {
    return Master(
      business_types: json['business_types'],
      designation: json['designation'],
      specialization: json['specialization'],
      state: json['state'],
      city: json['city'],
    );
  }
}
