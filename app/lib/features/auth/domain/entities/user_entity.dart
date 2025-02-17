import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? email;
  final List<String>? roles;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? address;
  final int? zipCode;
  final String? city;
  final String? country;

  const UserEntity({
    this.id,
    this.email,
    this.roles,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.zipCode,
    this.city,
    this.country,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        roles,
        firstName,
        lastName,
        phone,
        address,
        zipCode,
        city,
        country,
      ];
}
