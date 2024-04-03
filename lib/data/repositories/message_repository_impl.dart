import 'package:chatott/data/data_sources/message_data_source_impl.dart';
import 'package:chatott/domain/entities/message.dart';
import 'package:chatott/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageDataSourceImpl dataSource;

  MessageRepositoryImpl({
    required this.dataSource,
  });

  @override
  Stream<Message> getConservationMessage({required int conversationId}) {
    final messages = dataSource.getConversationMessage(conversationId);
    return messages;
  }

  @override
  Future<void> sendMessage(
      {required int conversationId, required String message}) async {
    return await dataSource.sendMessage(message, conversationId);
  }

  @override
  Future<void> deleteMessage({required String messageId}) async {
    return await dataSource.deleteMessage(
      messageId,
    );
  }
}
