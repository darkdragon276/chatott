import 'package:chatott/domain/repositories/message_repository.dart';
import 'package:chatott/domain/entities/message.dart';

class StreamGetConversationMessageUC {
  final MessageRepository repository;

  StreamGetConversationMessageUC(this.repository);

  Stream<Message> call(int conversationId) {
    try {
      return repository.getConservationMessage(conversationId: conversationId);
    } catch (e) {
      rethrow;
    }
  }
}
