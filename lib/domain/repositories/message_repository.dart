import 'package:chatott/domain/entities/message.dart';

abstract class MessageRepository {
  Stream<List<Message>> getConservationMessage({
    required int userId,
    required int conversationId,
  });

  Future<void> deleteMessage({
    required int messageId,
  });

  Future<void> sendMessage(
      {required int userId,
      required String content,
      required int conversationId,
      required String sessionId});
}
