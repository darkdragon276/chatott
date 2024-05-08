import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:chatott/data/models/user_model.dart';
import 'package:http/http.dart';

class AuthRemoteDataSourceImpl {
  static Client _http = Client();
  static UserModel _storeUser = UserModel.empty;

  UserModel get user {
    return _storeUser;
  }

  Future<UserModel> signUp(UserModel user) async {
    Response resp = await _http.post(
        Uri.parse('http://${dotenv.env["SERVER_URL"]}/kientrucphanmem/public/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));
    if (resp.statusCode == 200) {
      print('success');
      print(user.toJson());
      _storeUser = user;
      return user;
    }
    print("fail");
    throw Exception('Failed to sign up');
  }

  Future<UserModel> signIn({
    required String username,
    required String password,
  }) async {
    print("on singin");
    Response resp = await _http.post(
        Uri.parse('http://${dotenv.env["SERVER_URL"]}/kientrucphanmem/public/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          },
        body: jsonEncode(
            <String, String>{"username": username, "password": password}));
    if (resp.statusCode == 200) {
      print("I'm in here!");
      final json = jsonDecode(resp.body);
      if (json['code'] == 200) {
        final Map<String, dynamic> data = Map.castFrom(json['data']);
        print(data);
        _storeUser = UserModel.fromJson(data);
        return _storeUser;
      }
    }
    print("fail");
    throw Exception('Failed to sign in');
  }

  Future<void> signOut() async {
    throw UnimplementedError();
  }

  Future<List<UserModel>> getAllUser(String userJWT) async {
    Response resp = await _http.get(
        Uri.parse('http://${dotenv.env["SERVER_URL"]}/kientrucphanmem/user/get-all-user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $userJWT',
        });

    if (resp.statusCode != 200) {
      throw Exception('Failed to get user list');
    }

    final json = jsonDecode(resp.body);
    if (json['code'] != 200) {
      throw Exception('Failed to get user list');
    }

    Iterable listJson = json['data'];
    List<UserModel> listUser =
        listJson.map((user) => UserModel.fromJson(user)).toList();
    print('listUser: ${listUser.toString()}');
    return listUser;
  }
}
