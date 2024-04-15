import 'package:chatott/domain/entities/conversation.dart';

abstract class ConversationRepository {
  Future<List<Conversation>> getAllConversation(String userJWT);

  Future<Conversation> createConversation(
      List<String> listUser, String conversationName);

  // Future<List<Messages>> getMessage({required String conversationId});

  Future<void> deleteConversation({
    required String conversationId,
  });
}
