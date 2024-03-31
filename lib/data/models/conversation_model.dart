import 'package:chatott/domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  const ConversationModel({
    required super.id,
    required super.name,
    required super.status,
    required super.lastTime,
  });

  Conversation toEntity() {
    return this;
  }
}
