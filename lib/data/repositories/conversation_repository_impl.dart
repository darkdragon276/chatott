import 'package:chatott/data/data_sources/conversation_data_source_impl.dart';
import 'package:chatott/domain/entities/conversation.dart';
import 'package:chatott/domain/repositories/conversation_repository.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationDataSourceImpl remoteDataSource;

  const ConversationRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Stream<Conversation> get conversation {
    return remoteDataSource.conversation.map((conversationModel) =>
        conversationModel == null
            ? Conversation.empty
            : conversationModel.toEntity());
  }

  @override
  Future<Conversation> createConversation({
    required List<String> listUserId,
    required String conversationName,
  }) async {
    final conversationModel = await remoteDataSource.createConversation(
      listUserId: listUserId,
      conversationName: conversationName,
    );
    return conversationModel.toEntity();
  }

  @override
  Future<void> deleteConversation({
    required String conversationId,
  }) async {
    await remoteDataSource.deleteConversation(conversationId: conversationId);
  }
}
