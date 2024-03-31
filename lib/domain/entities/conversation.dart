class Conversation {
  final String id;
  final String name;
  final String status;
  final String lastTime;

  const Conversation({
    required this.id,
    required this.name,
    required this.status, // read, unread
    required this.lastTime,
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
    id: '',
    name: '',
    status: '',
    lastTime: '',
  );

  // An entity can be an object with methods, or it can be a set of
  // data structures and functions.
  bool get isEmpty => this == Conversation.empty;

  List<String?> get props => [id, name, status, lastTime];
}
