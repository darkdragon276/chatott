import 'package:chatott/domain/entities/conversation.dart';

abstract class ConversationRepository {
  Stream<Conversation> get conversation;

  Future<Conversation> createConversation({
    required List<String> listUserId,
    required String conversationName,
  });

  // Future<List<Messages>> getMessage({required String conversationId});

  Future<void> deleteConversation({
    required String conversationId,
  });
}
