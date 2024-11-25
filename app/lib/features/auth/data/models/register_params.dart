class RegisterParams {
  final String email;
  final String password;
  final String passwordConfirmation;
  final String firstName;
  final String lastName;
  final String? phone;
  final String? address;
  final String? zipCode;
  final String? city;
  final String? country;

  RegisterParams({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.address,
    this.zipCode,
    this.city,
    this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'zipCode': zipCode,
      'city': city,
      'country': country,
    };
  }
}
