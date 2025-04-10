class UserProfile {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
