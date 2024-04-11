import 'dart:convert';

import 'package:chatott/data/models/user_model.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class AuthRemoteDataSourceImpl {
  static Client _http = Client();
  static UserModel _storeUser = UserModel.empty;

  UserModel get user {
    return _storeUser;
  }

  static int userId = 5;
  static int conversationId = 1;
  static late StompClient stompClient;

  void onMessageReceived(StompFrame frame) {
    print('received: ${frame.body}');
  }

  void onConnect(StompFrame frame) {
    print('connected: ${frame.body}');
    stompClient.subscribe(
      destination: '/topic/public2',
      callback: onMessageReceived,
    );

    stompClient.send(
      destination: '/app/chat.register2',
      body: jsonEncode(<String, Object>{
        "msgFrom": userId,
        "type": "JOIN",
        "conversationId": conversationId,
      }),
    );
  }

  void connectSocket(int userId, int conversationId) {
    AuthRemoteDataSourceImpl.userId = userId;
    AuthRemoteDataSourceImpl.conversationId = conversationId;
    stompClient = StompClient(
        config: StompConfig.sockJS(
      url: 'http://localhost:8080/websocket',
      onConnect: onConnect,
      onStompError: (error) => print('Error: $error'),
      onWebSocketError: (error) => print('WebsocketError: $error'),
    ));
    stompClient.activate();
  }

  Future<UserModel> signUp(UserModel user) async {
    Response resp = await _http.post(
        Uri.parse('http://localhost:8080/kientrucphanmem/public/register'),
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
    print("singin");
    Response resp = await _http.post(
        Uri.parse('http://localhost:8080/kientrucphanmem/public/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{"username": username, "password": password}));

    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body);
      final Map<String, dynamic> data = Map.castFrom(json['data']);
      print(data);
      _storeUser = UserModel.fromJson(data);
      return _storeUser;
    }
    print("fail");
    throw Exception('Failed to sign in');
  }

  Future<void> signOut() async {
    throw UnimplementedError();
  }
}
