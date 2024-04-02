import 'package:chatott/domain/entities/user.dart';

abstract class AuthRepository {
  User get storeUser;

  Future<User> signUp(User user);

  Future<User> signIn({
    required String username,
    required String password,
  });

  Future<void> signOut();
}
