import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required int id,
    required String username,
    required String email,
  }) : super(id: id, username: username, email: email);

  /// Создание UserModel из JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  /// Преобразование UserModel в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}
