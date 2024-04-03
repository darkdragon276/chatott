class Conversation {
  final int id;
  final List<String> listUsername;
  final String? status;
  final int createAt;

  const Conversation({
    required this.id,
    required this.listUsername,
    this.status, // read, unread
    required this.createAt,
  });

  // compare with id object.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Conversation &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  static const Conversation empty = Conversation(
    id: -1,
    listUsername: [],
    status: 'unread',
    createAt: 1712109344,
  );

  // An entity can be an object with methods, or it can be a set of
  // data structures and functions.
  bool get isEmpty => this == Conversation.empty;
}
