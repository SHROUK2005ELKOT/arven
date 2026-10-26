class RefreshTokenRequestModel {
  final String refreshToken;
  final bool useCookies;

  const RefreshTokenRequestModel({
    required this.refreshToken,
    this.useCookies = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
      'useCookies': useCookies,
    };
  }
}
