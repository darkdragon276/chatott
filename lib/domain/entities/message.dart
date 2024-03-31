import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class Message {
  final String id;
  final Sender sender;
  final String content;
  final String status;
  final String lastTime;

  const Message({
    required this.id,
    required this.sender,
    required this.content,
    required this.status, // read, unread
    required this.lastTime,
  });

  // compare with id object.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  static const Message empty = Message(
    id: '',
    sender: Sender(id: '', lastName: '', firstName: '', avatar: ''),
    content: '',
    status: '',
    lastTime: '',
  );

  // An entity can be an object with methods, or it can be a set of
  // data structures and functions.
  bool get isEmpty => this == Message.empty;

  List<String?> get props => [
        id,
        sender.lastName,
        sender.firstName,
        sender.avatar,
        content,
        status,
        lastTime
      ];

  types.TextMessage toTextMessage() {
    return types.TextMessage(
        author: sender.toChatTypeUser(), id: id, text: content);
  }
}

class Sender {
  final String id;
  final String? email;
  final String? phone;
  final String lastName;
  final String firstName;
  final String avatar;

  const Sender({
    required this.id,
    this.email,
    this.phone,
    required this.lastName,
    required this.firstName,
    required this.avatar,
  });

  types.User toChatTypeUser() {
    return types.User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      imageUrl: avatar,
    );
  }
}
