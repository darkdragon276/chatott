import 'package:chatott/domain/entities/conversation.dart';
import 'package:chatott/domain/repositories/conversation_repository.dart';

class CreateConversationUseCase {
  final ConversationRepository repository;

  CreateConversationUseCase(this.repository);

  Future<Conversation> call(
      List<String> listUser, String conversationName) async {
    try {
      return await repository.createConversation(listUser, conversationName);
    } catch (e) {
      rethrow;
    }
  }
}
