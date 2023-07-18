class User {
  final int? id;
  final String name;
  final String email;
  final String? firebaseId;

  User({
    this.id,
    required this.name,
    required this.email,
    this.firebaseId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        firebaseId: json["firebaseId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "firebaseId": firebaseId,
      };

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? firebaseId,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      firebaseId: firebaseId ?? this.firebaseId,
    );
  }
}
