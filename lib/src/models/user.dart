class User {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? token; // JWT or Firebase token

  User({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.token,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'phoneNumber': phoneNumber,
        'name': name,
        'token': token,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      name: json['name'],
      token: json['token'],
    );
  }
}
