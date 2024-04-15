import 'package:chatott/domain/entities/user.dart';
import 'package:chatott/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  Future<User> call(SignInParams params) async {
    try {
      return await repository.signIn(
        username: params.username,
        password: params.password,
      );
    } catch (e) {
      rethrow;
    }
  }
}

class SignInParams {
  final String username;
  final String password;

  SignInParams({required this.username, required this.password});
}
