import 'package:chatott/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser> get authUser;

  Future<AuthUser> signUp({
    required String email,
    required String password,
  });

  Future<AuthUser> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
