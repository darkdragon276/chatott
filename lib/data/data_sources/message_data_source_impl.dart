import 'dart:math';

import 'package:chatott/data/models/message_model.dart';
import 'package:chatott/domain/entities/message.dart';

class MessageDataSourceImpl {
  static List<MessageModel> fakeListMessage = List.generate(
    10,
    (index) => MessageModel(
      id: 'id$index',
      sender: SenderModel(
        id: (index % 2).toString(),
        firstName: 'Ngo Quoc',
        lastName: 'Minh' + (index % 2).toString(),
        avatar: 'https://picsum.photos/id/300/200/200',
      ),
      content: 'loremislum sfs $index fsfsfs',
      status: 'read',
      lastTime: 1655648403000 + index * 1000000000,
    ),
  );

  Future<void> sendMessage(String message, String conversationId) async {
    MessageModel newMessage = MessageModel(
      id: Random().nextInt(100).toString(),
      sender: SenderModel(
        id: '1',
        firstName: 'Ngo Quoc',
        lastName: 'Minh1',
        avatar: 'https://picsum.photos/id/300/200/200',
      ),
      content: message,
      status: 'read',
      lastTime: 1655648403000,
    );
    fakeListMessage.add(newMessage);
  }

  Future<void> deleteMessage(String messageId) async {
    fakeListMessage.removeWhere((element) => element.id == messageId);
  }

  Stream<MessageModel> getConversationMessage(String conversationId) {
    if (conversationId == "1") {
      return Stream.fromIterable(fakeListMessage);
    } else {
      return Stream.empty();
    }
  }
}
