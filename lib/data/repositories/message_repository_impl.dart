import 'package:chatott/data/data_sources/message_data_source_impl.dart';
import 'package:chatott/domain/entities/message.dart';
import 'package:chatott/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageDataSourceImpl dataSource;

  MessageRepositoryImpl({
    required this.dataSource,
  });

  @override
  Stream<List<Message>> getConservationMessage(
      {required int userId, required int conversationId}) {
    final messages = dataSource.getConversationMessage(userId, conversationId);
    return messages;
  }

  @override
  Future<void> sendMessage(
      {required int userId,
      required String content,
      required int conversationId,
      required String sessionId}) async {
    return await dataSource.sendMessage(
        userId, content, conversationId, sessionId);
  }

  @override
  Future<void> deleteMessage({required int messageId}) async {
    return await dataSource.deleteMessage(
      messageId,
    );
  }
}
