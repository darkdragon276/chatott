import 'package:chatott/domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  const ConversationModel({
    required super.id,
    required super.listUsername,
    super.status,
    required super.createAt,
  });

  Conversation toEntity() {
    return this;
  }

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'],
      listUsername: json['name'].toString().replaceAll(" ", "").split(',').toList(),
      status: json['status'],
      createAt: json['createdDate'].runtimeType == int ? json['createdDate'] : 
      DateTime.parse(json['createdDate']).microsecondsSinceEpoch,
    );
  }

  factory ConversationModel.fromEntity(Conversation entity) {
    return ConversationModel(
      id: entity.id,
      listUsername: entity.listUsername,
      status: entity.status,
      createAt: entity.createAt,
    );
  }

  static const ConversationModel empty = ConversationModel(
    id: -1,
    listUsername: [],
    status: 'unread',
    createAt: 1712109344,
  );
}
