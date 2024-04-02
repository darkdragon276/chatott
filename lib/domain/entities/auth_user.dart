class AuthUser {
  final int id;
  final String email;
  final String? name;
  final String? photoURL;

  const AuthUser({
    required this.id,
    required this.email,
    this.name,
    this.photoURL,
  });

  // compare with id object.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUser && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  static const AuthUser empty = AuthUser(
    id: -1,
    name: '',
    email: '',
    photoURL: '',
  );

  // An entity can be an object with methods, or it can be a set of
  // data structures and functions.
  bool get isEmpty => this == AuthUser.empty;

  List<Object?> get props => [id, name, email, photoURL];
}
