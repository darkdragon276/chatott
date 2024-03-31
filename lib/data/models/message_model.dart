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
