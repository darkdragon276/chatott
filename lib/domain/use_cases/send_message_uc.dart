import 'package:chatott/domain/repositories/message_repository.dart';

class SendMessageUC {
  final MessageRepository repository;

  SendMessageUC(this.repository);

  Future<void> call(
      {required int userId,
      required String content,
      required int conversationId,
      required String sessionId}) async {
    try {
      return await repository.sendMessage(
        userId: userId,
        content: content,
        conversationId: conversationId,
        sessionId: sessionId,
      );
    } catch (e) {
      rethrow;
    }
  }
}
