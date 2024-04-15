import 'package:chatott/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.username,
      super.password,
      super.email,
      super.phoneNumber,
      super.firstName,
      super.lastName,
      super.photoURL,
      super.jwt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      photoURL: 'https://picsum.photos/id/${json['id'] * 2}/200/200',
      jwt: json['jwt'],
    );
  }

  factory UserModel.fromJsonWithoutJwt(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      photoURL: 'https://picsum.photos/id/${json['id'] * 2}/200/200',
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      password: user.password,
      email: user.email,
      phoneNumber: user.phoneNumber,
      firstName: user.firstName,
      lastName: user.lastName,
      // photoURL: user.photoURL, TODO: uncomment this line
      // jwt: user.jwt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  User toEntity() {
    return this;
  }

  static const UserModel empty = UserModel(
    id: -1,
    username: '',
  );
}
