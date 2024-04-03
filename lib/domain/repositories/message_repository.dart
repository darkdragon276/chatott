import 'package:chatott/domain/entities/message.dart';

abstract class MessageRepository {
  Stream<Message> getConservationMessage({
    required int conversationId,
  });

  Future<void> deleteMessage({
    required String messageId,
  });

  Future<void> sendMessage({
    required int conversationId,
    required String message,
  });
}
