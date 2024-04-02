import 'package:chatott/domain/entities/auth_user.dart';
import 'package:chatott/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  Future<AuthUser> call(SignInParams params) async {
    try {
      return await repository.signIn(
        id: params.id,
        password: params.password,
      );
    } catch (e) {
      rethrow;
    }
  }
}

class SignInParams {
  final String id;
  final String password;

  SignInParams({required this.id, required this.password});
}
