import 'dart:math';

import 'package:chatott/data/models/conversation_model.dart';

class ConversationDataSourceImpl {
  static List<ConversationModel> fakeListConversation = List.generate(
    10,
    (index) => ConversationModel(
      id: '$index',
      name: 'name$index',
      status: 'status$index',
      lastTime: '11PM$index',
    ),
  );

  Stream<ConversationModel?> get conversation {
    return Stream.fromIterable(fakeListConversation);
  }

  Future<ConversationModel> createConversation({
    required List<String> listUserId,
    required String conversationName,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    ConversationModel conversation = ConversationModel(
      id: generateRandomString(10),
      name: 'name',
      status: 'status',
      lastTime: '11PM',
    );
    fakeListConversation.add(conversation);
    return conversation;
  }

  Future<void> deleteConversation({
    required String conversationId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    fakeListConversation.removeWhere((element) => element.id == conversationId);
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }
}
