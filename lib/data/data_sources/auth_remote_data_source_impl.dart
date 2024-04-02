import 'dart:collection';
import 'dart:convert';

import 'package:chatott/data/data_sources/auth_remote_data_source.dart';
import 'package:chatott/data/models/auth_user_model.dart';
import 'package:http/http.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const fakeUser = AuthUserModel(
    id: 1000,
    email: 'fake-user-email',
    name: 'fake-user-name',
  );
  static Client _http = Client();

  @override
  Stream<AuthUserModel?> get user {
    return Stream.value(fakeUser);
  }

  @override
  Future<AuthUserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return fakeUser;
  }

  @override
  Future<AuthUserModel> signInWithIdAndPassword({
    required String id,
    required String password,
  }) async {
    print("singin");
    Response resp = await _http.post(
        Uri.parse('http://localhost:8080/kientrucphanmem/public/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{"username": id, "password": password}));

    if (resp.statusCode == 200) {
      print("success");
      final json = jsonDecode(resp.body);
      print(json['data']);
      print(json['data']['id']);
      final user = AuthUserModel(
          id: json['data']['id'],
          email: json['data']['email'],
          name: json['data']['lastName']);
      return user;
    }
    print("fail");
    throw Exception('Failed to sign in');
  }

  @override
  Future<void> signOut() async {
    throw UnimplementedError();
  }
}
