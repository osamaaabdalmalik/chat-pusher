import 'package:pusher/features/auth/data/models/user_model.dart';
import 'package:pusher/features/auth/domain/entities/user_auth_entity.dart';

class UserAuthModel extends UserAuth {
  const UserAuthModel({
    required super.user,
    required super.token,
  });

  factory UserAuthModel.fromJson(Map<String, dynamic> json) {
    return UserAuthModel(
      user: UserModel.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toModel().toJson(),
      'token': token,
    };
  }
}
