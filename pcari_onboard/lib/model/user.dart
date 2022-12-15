import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class MyUserHive extends HiveObject {
  @HiveField(0)
  String themeModeString; // light, dark, system
  
  MyUserHive({
    required this.themeModeString,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'themeModeString': themeModeString});
  
    return result;
  }

  factory MyUserHive.fromMap(Map<String, dynamic> map) {
    return MyUserHive(
      themeModeString: map['themeModeString'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUserHive.fromJson(String source) => MyUserHive.fromMap(json.decode(source));
}
