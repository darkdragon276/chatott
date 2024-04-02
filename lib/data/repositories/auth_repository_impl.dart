import 'package:chatott/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:chatott/data/models/user_model.dart';
import 'package:chatott/domain/entities/user.dart';
import 'package:chatott/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSourceImpl remoteDataSource;

  const AuthRepositoryImpl({required this.remoteDataSource});

  @override
  User get storeUser {
    return remoteDataSource.user.toEntity();
  }

  @override
  Future<User> signUp(User user) async {
    final authModel = await remoteDataSource.signUp(UserModel.fromEntity(user));
    return authModel.toEntity();
  }

  @override
  Future<User> signIn({
    required String username,
    required String password,
  }) async {
    final authModel = await remoteDataSource.signIn(
      username: username,
      password: password,
    );
    return authModel.toEntity();
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}
