import 'package:chatott/domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.sender,
    required super.content,
    required super.status,
    required super.lastTime,
  });

  Message toEntity() {
    return this;
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      sender: SenderModel(
        id: json['msgFrom'],
        firstName: json['sender'],
        lastName: json['sender'],
        avatar: 'https://picsum.photos/id/300/200/200',
      ),
      content: json['content'],
      status: 'read',
      lastTime: json['createdDate'],
    );
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
