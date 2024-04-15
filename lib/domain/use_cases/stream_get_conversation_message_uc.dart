import 'package:chatott/domain/repositories/message_repository.dart';
import 'package:chatott/domain/entities/message.dart';

class StreamGetConversationMessageUC {
  final MessageRepository repository;

  StreamGetConversationMessageUC(this.repository);

  Stream<List<Message>> call(int userId, int conversationId) {
    try {
      return repository.getConservationMessage(
          userId: userId, conversationId: conversationId);
    } catch (e) {
      rethrow;
    }
  }
}
