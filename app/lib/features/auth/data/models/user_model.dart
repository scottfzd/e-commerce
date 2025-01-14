import 'package:app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.email,
    super.roles,
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
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phone: json['phone'] ?? 0,
      address: json['address'] ?? '',
      zipCode: json['zipCode'] ?? 0,
      city: json['city'] ?? '',
      country: json['country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'roles': roles,
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
      roles: roles,
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
