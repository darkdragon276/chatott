import 'package:chatott/data/data_sources/auth_remote_data_source.dart';
import 'package:chatott/data/models/auth_user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const fakeUser = AuthUserModel(
    id: 'fake-user-id',
    email: 'fake-user-email',
    name: 'fake-user-name',
  );

  @override
  Stream<AuthUserModel?> get user {
    return Stream.value(fakeUser);
  }

  @override
  Future<AuthUserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return fakeUser;
  }

  @override
  Future<AuthUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return fakeUser;
  }

  @override
  Future<void> signOut() async {
    throw UnimplementedError();
  }
}
