import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'contact.g.dart';

@HiveType(typeId: 1)
class Contact {
  @HiveField(0)
  int id;
  @HiveField(1)
  String email;
  @HiveField(2)
  String firstName;
  @HiveField(3)
  String lastName;
  @HiveField(4)
  String avatar;
  @HiveField(5)
  bool isFavorite;
  @HiveField(6)
  String? path;
  
  Contact({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.isFavorite,
    this.path,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'email': email});
    result.addAll({'first_name': firstName});
    result.addAll({'last_name': lastName});
    result.addAll({'avatar': avatar});
    result.addAll({'isFavorite': isFavorite});
    if(path != null){
      result.addAll({'path': path});
    }
  
    return result;
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id']?.toInt() ?? 0,
      email: map['email'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      avatar: map['avatar'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
      path: map['path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) => Contact.fromMap(json.decode(source));
}
