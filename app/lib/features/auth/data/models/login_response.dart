import 'package:app/features/auth/data/models/user_model.dart';
import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final UserEntity user;
  final String? token;
  final String? refreshToken;

  const LoginResponse({
    required this.user,
    this.token,
    this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: UserModel.fromJson(json['user']).toEntity(),
      token: json['token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        token,
        refreshToken,
        user,
      ];
}
