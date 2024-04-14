import 'package:chatott/domain/repositories/message_repository.dart';

class DeleteMessageUC {
  final MessageRepository repository;

  DeleteMessageUC(this.repository);

  Future<void> call(int messageId) async {
    try {
      return await repository.deleteMessage(
        messageId: messageId,
      );
    } catch (e) {
      rethrow;
    }
  }
}
