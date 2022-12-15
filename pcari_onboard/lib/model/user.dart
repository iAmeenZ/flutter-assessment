import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcari_onboard/model/contact.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class MyUserHive extends HiveObject {
  @HiveField(0)
  String themeModeString; // light, dark, system
  @HiveField(1)
  List<Contact> contacts;
  
  MyUserHive({
    required this.themeModeString,
    required this.contacts,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'themeModeString': themeModeString});
    result.addAll({'contacts': contacts.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory MyUserHive.fromMap(Map<String, dynamic> map) {
    return MyUserHive(
      themeModeString: map['themeModeString'] ?? '',
      contacts: List<Contact>.from(map['contacts']?.map((x) => Contact.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUserHive.fromJson(String source) => MyUserHive.fromMap(json.decode(source));
}
