import 'dart:convert';

class UserModel {
  final String? id;
  final String name;
  final String? photoURL;

  UserModel({
    this.id,
    required this.name,
    this.photoURL,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      photoURL: map['photoURL'],
    );
  }

  factory UserModel.fromJSON(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photoURL': photoURL,
    };
  }

  String toJSON() => jsonEncode(toMap());

  UserModel copyWith({
    String? id,
    String? name,
    String? photoURL,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(id: $id, name: $name, photoURL: $photoURL)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ photoURL.hashCode;
}
