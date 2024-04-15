import 'package:chatott/domain/entities/conversation.dart';
import 'package:chatott/domain/repositories/conversation_repository.dart';

class GetAllConversationUseCase {
  final ConversationRepository repository;

  GetAllConversationUseCase({required this.repository});

  Future<List<Conversation>> call(String userJWT) {
    try {
      return repository.getAllConversation(userJWT);
    } catch (e) {
      rethrow;
    }
  }
}
