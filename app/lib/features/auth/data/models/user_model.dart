import 'package:app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? password;

  const UserModel({
    super.id,
    super.email,
    this.password,
    super.firstName,
    super.lastName,
    super.phone,
    super.address,
    super.zipCode,
    super.city,
    super.country,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      address: json['address'],
      zipCode: json['zipCode'],
      city: json['city'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'zipCode': zipCode,
      'city': city,
      'country': country,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      address: address,
      zipCode: zipCode,
      city: city,
      country: country,
    );
  }
}
