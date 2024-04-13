import 'dart:convert';
import 'dart:math';

import 'package:chatott/data/models/message_model.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class MessageDataSourceImpl {
  static List<MessageModel> _storeListMessage = [];

  static late StompClient stompClient;

  void onMessageReceived(StompFrame frame) {
    Iterable listJson = jsonDecode(frame.body!);
    _storeListMessage =
        listJson.map((message) => MessageModel.fromJson(message)).toList();
    print(_storeListMessage);
  }

  void onConnect(StompFrame frame, int userId, int conversationId) {
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
    print("userId: $userId; conversationId: $conversationId");
    stompClient = StompClient(
        config: StompConfig.sockJS(
      url: 'http://localhost:8080/websocket',
      onConnect: (StompFrame frame) => onConnect(frame, userId, conversationId),
      onStompError: (error) => print('Error: $error'),
      onWebSocketError: (error) => print('WebsocketError: $error'),
    ));

    if (!stompClient.connected) {
      stompClient.activate();
    }
  }

  void disconnectSocket() {
    if (stompClient.connected) {
      stompClient.deactivate();
    }
  }

  Future<void> sendMessage(String message, int conversationId) async {
    MessageModel newMessage = MessageModel(
      id: Random().nextInt(100),
      sender: SenderModel(
        id: 1,
        firstName: 'Ngo Quoc',
        lastName: 'Minh1',
        avatar: 'https://picsum.photos/id/300/200/200',
      ),
      content: message,
      status: 'read',
      lastTime: 1655648403000,
    );
    _storeListMessage.add(newMessage);
  }

  Future<void> deleteMessage(String messageId) async {
    _storeListMessage.removeWhere((element) => element.id == messageId);
  }

  Stream<MessageModel> getConversationMessage(int conversationId) {
    if (conversationId == 1) {
      return Stream.fromIterable(_storeListMessage.reversed);
    } else {
      return Stream.empty();
    }
  }
}
