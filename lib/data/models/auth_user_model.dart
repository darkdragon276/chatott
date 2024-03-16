import 'package:chatott/domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  const AuthUserModel(
      {required super.id, required super.email, super.name, super.photoURL});

  // factory AuthUserModel.fromAnotherDataSourceAuthUser(
  //   // ...
  // ) {
  //   return AuthUserModel(
  //     ...
  //   );
  // }

  AuthUser toEntity() {
    return this;
  }
}
