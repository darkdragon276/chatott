import 'package:chatott/domain/entities/conversation.dart';
import 'package:chatott/domain/repositories/conversation_repository.dart';

class CreateConversationUseCase {
  final ConversationRepository repository;

  CreateConversationUseCase(this.repository);

  Future<Conversation> call(String userJWT) async {
    try {
      return await repository.createConversation(userJWT);
    } catch (e) {
      rethrow;
    }
  }
}
