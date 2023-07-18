class User {
  final int? id;
  final String name;
  final String email;
  final bool? isVerified;
  final String? firebaseId;

  User({
    this.id,
    required this.name,
    required this.email,
    this.isVerified,
    this.firebaseId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        isVerified: json["is_verified"],
        firebaseId: json["firebaseId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "is_verified": isVerified,
        "firebaseId": firebaseId,
      };

  User copyWith({
    int? id,
    String? name,
    String? email,
    bool? isVerified,
    String? firebaseId,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isVerified: isVerified ?? this.isVerified,
      firebaseId: firebaseId ?? this.firebaseId,
    );
  }
}
