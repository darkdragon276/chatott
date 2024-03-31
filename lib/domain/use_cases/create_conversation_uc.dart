import 'package:chatott/domain/entities/conversation.dart';
import 'package:chatott/domain/repositories/conversation_repository.dart';

class CreateConversationUseCase {
  final ConversationRepository repository;

  CreateConversationUseCase(this.repository);

  Future<Conversation> call(CreateConversationParams params) async {
    try {
      return await repository.createConversation(
        listUserId: params.listUserId,
        conversationName: params.conversationName,
      );
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}

class CreateConversationParams {
  final List<String> listUserId;
  final String conversationName;

  CreateConversationParams(
      {required this.listUserId, required this.conversationName});
}
