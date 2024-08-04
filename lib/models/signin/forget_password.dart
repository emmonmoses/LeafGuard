class UserEmail {
  final String email;

  UserEmail({
    required this.email,
  });

  factory UserEmail.fromJson(Map<String, dynamic> json) {
    return UserEmail(
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
