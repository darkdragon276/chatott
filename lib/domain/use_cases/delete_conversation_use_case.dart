import 'package:chatott/domain/repositories/conversation_repository.dart';

class DeleteConversationUseCase {
  final ConversationRepository repository;

  DeleteConversationUseCase(this.repository);

  Future<void> call(String conversationId) async {
    try {
      return await repository.deleteConversation(
        conversationId: conversationId,
      );
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}
