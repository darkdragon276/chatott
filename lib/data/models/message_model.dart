import 'package:chatott/domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.sender,
    required super.content,
    required super.status,
    required super.lastTime,
    required super.sessionId,
  });

  Message toEntity() {
    return this;
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      sender: SenderModel(
        id: json['msgFrom'],
        firstName: "",
        lastName: json['sender'],
        avatar: 'https://picsum.photos/id/${json['msgFrom'] * 2}/200/200',
      ),
      content: json['content'],
      status: 'read',
      lastTime: json['createdDate'],
      sessionId: json['sessionId'],
    );
  }

  static Map<String, dynamic> toJson(
      String userName, String content, int conversationId, int sessionId) {
    return {
      'msgFrom': userName,
      'content': content,
      'type': 'CHAT',
      'conversationId': conversationId,
      'sessionId': sessionId,
    };
  }
}

class SenderModel extends Sender {
  const SenderModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.avatar,
  });

  Sender toEntity() {
    return this;
  }
}
