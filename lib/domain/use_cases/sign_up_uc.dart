import 'package:chatott/domain/entities/user.dart';
import 'package:chatott/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<User> call(User user) async {
    try {
      User authUser = await authRepository.signUp(user);
      return authUser;
    } catch (e) {
      rethrow;
    }
  }
}
