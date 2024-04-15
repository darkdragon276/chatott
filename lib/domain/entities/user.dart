class User {
  final int? id;
  final String username;
  final String? password;
  final String? email;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? photoURL;
  final String? jwt;

  const User({
    this.id,
    required this.username,
    this.password,
    this.email,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.photoURL,
    this.jwt,
  });

  // compare with id object.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          username == other.username;

  @override
  int get hashCode => username.hashCode;

  static const User empty = User(
    id: -1,
    username: '',
  );

  // An entity can be an object with methods, or it can be a set of
  // data structures and functions.
  bool get isEmpty => this == User.empty;
}
