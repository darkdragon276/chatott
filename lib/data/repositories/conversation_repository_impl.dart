import 'package:chatott/data/data_sources/conversation_data_source_impl.dart';
import 'package:chatott/domain/entities/conversation.dart';
import 'package:chatott/domain/repositories/conversation_repository.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationDataSourceImpl remoteDataSource;

  const ConversationRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<Conversation>> getAllConversation(String userJWT) async {
    final listConversation = await remoteDataSource.getAllConversation(userJWT);
    final List<Conversation> ret =
        listConversation.map((e) => e.toEntity()).toList();
    return ret;
  }

  @override
  Future<Conversation> createConversation(
      List<String> listUser, String conversationName) async {
    final conversationModel =
        await remoteDataSource.createConversation(listUser, conversationName);
    return conversationModel.toEntity();
  }

  @override
  Future<void> deleteConversation({
    required String conversationId,
  }) async {
    await remoteDataSource.deleteConversation(conversationId: conversationId);
  }
}
