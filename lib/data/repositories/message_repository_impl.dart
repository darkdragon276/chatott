import 'package:chatott/data/data_sources/message_data_source_impl.dart';
import 'package:chatott/domain/entities/message.dart';
import 'package:chatott/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageDataSourceImpl dataSource;

  MessageRepositoryImpl({
    required this.dataSource,
  });

  @override
  Stream<Message> getConservationMessage({required String conversationId}) {
    try {
      final messages = dataSource.getConversationMessage(conversationId);
      return messages;
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> sendMessage(
      {required String conversationId, required String message}) async {
    try {
      return await dataSource.sendMessage(message, conversationId);
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> deleteMessage({required String messageId}) async {
    try {
      return await dataSource.deleteMessage(
        messageId,
      );
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}
