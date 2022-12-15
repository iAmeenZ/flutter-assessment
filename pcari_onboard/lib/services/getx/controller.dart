import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcari_onboard/model/user.dart';

class MyController extends GetxController {

  static MyController get to => Get.find();

  late Rx<MyUserHive> myUserHive = Hive.box<MyUserHive>('user').get(0)!.obs; // initialize in initHive()

  // INIT AT VOID MAIN FOR LOCAL STORAGE
  Future<bool> initHiveAndGetX() async {
    try {
      Get.put(MyController());
      await Hive.initFlutter();
      Hive.registerAdapter(MyUserHiveAdapter());

      Box<MyUserHive> box = await Hive.openBox<MyUserHive>('user');
      // FIRST INSTALL
      if (box.get(0) == null) {
        myUserHive = MyUserHive(
          themeModeString: 'light'
        ).obs;
        await box.put(0,  myUserHive.value);
        return true;
      } else {
        myUserHive = Hive.box<MyUserHive>('user').get(0)!.obs;
        return false;
      }
    } catch (e) {
      debugPrint('ERROR initHiveAndGetX() : $e');
      return true;
    }
  }

  void changeThemeMode({
    required ThemeMode themeMode
  }) {
    Get.changeThemeMode(themeMode);
    myUserHive.value.themeModeString = themeMode.name;
    myUserHive.value.save();
    update(['changeThemeMode']);
  }
}