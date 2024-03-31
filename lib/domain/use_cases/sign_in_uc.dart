import 'package:chatott/domain/entities/auth_user.dart';
import 'package:chatott/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  Future<AuthUser> call(SignInParams params) async {
    try {
      return await repository.signIn(
        email: params.email,
        password: params.password,
      );
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}
