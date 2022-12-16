import 'package:flutter/material.dart';
import 'package:pcari_onboard/model/user.dart';
import 'package:pcari_onboard/services/controller/controller.dart';

ThemeMode currentThemeMode() {
  MyUserHive myUserHive = MyController.to.myUserHive.value;
  if (myUserHive.themeModeString == 'light') {
    return ThemeMode.light;
  } else if (myUserHive.themeModeString == 'dark') {
    return ThemeMode.dark;
  } else {
    return ThemeMode.system;
  }
}

String themeModeString() {
  MyUserHive myUserHive = MyController.to.myUserHive.value;
  if (myUserHive.themeModeString == 'light') {
    return 'Light Mode';
  } else if (myUserHive.themeModeString == 'dark') {
    return 'Dark Mode';
  } else {
    return 'System Default';
  }
}