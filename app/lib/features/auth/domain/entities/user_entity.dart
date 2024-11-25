import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? address;
  final String? zipCode;
  final String? city;
  final String? country;

  const UserEntity({
    this.id,
    this.email,
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
        firstName,
        lastName,
        phone,
        address,
        zipCode,
        city,
        country,
      ];
}
