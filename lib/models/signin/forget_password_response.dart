class PasswordResetResponse {
  final String? message;
  final String? error;

  PasswordResetResponse({this.message, this.error});

  factory PasswordResetResponse.fromJson(Map<String, dynamic> json) {
    return PasswordResetResponse(
      message: json['message'],
      error: json['error'],
    );
  }
}