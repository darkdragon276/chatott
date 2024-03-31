import 'package:chatott/domain/repositories/message_repository.dart';

class SendMessageUC {
  final MessageRepository repository;

  SendMessageUC(this.repository);

  Future<void> call(String conversationId, String message) async {
    try {
      return await repository.sendMessage(
        conversationId: conversationId,
        message: message,
      );
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}
