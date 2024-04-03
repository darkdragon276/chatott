import 'package:chatott/domain/repositories/message_repository.dart';

class SendMessageUC {
  final MessageRepository repository;

  SendMessageUC(this.repository);

  Future<void> call(int conversationId, String message) async {
    try {
      return await repository.sendMessage(
        conversationId: conversationId,
        message: message,
      );
    } catch (e) {
      rethrow;
    }
  }
}
