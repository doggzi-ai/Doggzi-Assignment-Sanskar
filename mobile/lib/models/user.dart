class User {
  final String email;
  final String token;

  User({required this.email, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(email: json['email'] ?? '', token: json['access_token'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'access_token': token};
  }
}
