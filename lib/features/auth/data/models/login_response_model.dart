class LoginResponseModel {
  final String accessToken;
  final DateTime expiresAtUtc;
  final String refreshToken;

  const LoginResponseModel({
    required this.accessToken,
    required this.expiresAtUtc,
    required this.refreshToken,
  });

  factory LoginResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return LoginResponseModel(
      accessToken: json['accessToken'] as String,
      expiresAtUtc: DateTime.parse(
        json['expiresAtUtc'] as String,
      ),
      refreshToken: json['refreshToken'] as String,
    );
  }
}
