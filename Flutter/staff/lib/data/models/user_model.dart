class User {
  String name;
  String email;
  String role;
  String title;
  int hour;
  String id;

  User({
    required this.name,
    required this.email,
    required this.role,
    required this.title,
    required this.hour,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      email: json["email"],
      role: json["role"],
      title: json["title"],
      hour: json["hourPrice"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'role': role,
        'title': title,
        'hourPrice': hour,
      };
}
