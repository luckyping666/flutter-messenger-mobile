import '../../domain/entities/token.dart';

class TokenModel extends Token {
  const TokenModel({
    required String accessToken,
    required String refreshToken,
  }) : super(accessToken: accessToken, refreshToken: refreshToken);

  /// Создание TokenModel из JSON
  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  /// Преобразование TokenModel в JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
