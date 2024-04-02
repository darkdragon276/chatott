import 'package:chatott/data/data_sources/auth_remote_data_source.dart';
import 'package:chatott/domain/entities/auth_user.dart';
import 'package:chatott/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<AuthUser> get authUser {
    return remoteDataSource.user.map((authUserModel) =>
        authUserModel == null ? AuthUser.empty : authUserModel.toEntity());
  }

  @override
  Future<AuthUser> signUp({
    required String email,
    required String password,
  }) async {
    final authModel = await remoteDataSource.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
    return authModel.toEntity();
  }

  @override
  Future<AuthUser> signIn({
    required String id,
    required String password,
  }) async {
    final authModel = await remoteDataSource.signInWithIdAndPassword(
      id: id,
      password: password,
    );
    return authModel.toEntity();
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}
