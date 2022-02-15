import 'dart:convert';

class InfosUser {
  final String name;
  final String phoneNumber;
  InfosUser({
    required this.name,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  factory InfosUser.fromMap(Map<String, dynamic> map) {
    return InfosUser(
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InfosUser.fromJson(String source) => InfosUser.fromMap(json.decode(source));
}
