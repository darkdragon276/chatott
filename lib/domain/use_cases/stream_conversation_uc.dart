import 'package:chatott/domain/entities/conversation.dart';
import 'package:chatott/domain/repositories/conversation_repository.dart';

class StreamConversationUseCase {
  final ConversationRepository repository;

  StreamConversationUseCase({required this.repository});

  Stream<Conversation> call() {
    try {
      return repository.conversation;
    } catch (e) {
      rethrow;
    }
  }
}
