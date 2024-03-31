import 'package:chatott/domain/entities/message.dart';

abstract class MessageRepository {
  Stream<Message> getConservationMessage({
    required String conversationId,
  });

  Future<void> deleteMessage({
    required String messageId,
  });

  Future<void> sendMessage({
    required String conversationId,
    required String message,
  });
}
