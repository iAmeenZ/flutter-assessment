import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcari_onboard/constants/constants.dart';
import 'package:pcari_onboard/model/contact.dart';
import 'package:pcari_onboard/model/response.dart';
import 'package:pcari_onboard/model/user.dart';
import 'package:pcari_onboard/services/http/request.dart';
import 'package:pcari_onboard/widget/dialog/dialog_error.dart';

class MyController extends GetxController {

  static MyController get to => Get.find();

  late Rx<MyUserHive> myUserHive = Hive.box<MyUserHive>('user').get(0)!.obs; // initialize in initHive()

  // INIT AT VOID MAIN FOR LOCAL STORAGE
  Future<bool> initHiveAndGetX() async {
    try {
      Get.put(MyController());
      
      Hive
        ..registerAdapter(MyUserHiveAdapter())
        ..registerAdapter(ContactAdapter());

      Box<MyUserHive> box = await Hive.openBox<MyUserHive>('user');
      // FIRST INSTALL
      if (box.get(0) == null) {
        myUserHive = MyUserHive(
          themeModeString: 'light',
          contacts: []
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

  void addFavorite({
    required int id
  }) {
    int index = myUserHive.value.contacts.indexWhere((e) => e.id == id);
    if (index != -1) {
      myUserHive.value.contacts[index].isFavorite = !myUserHive.value.contacts[index].isFavorite;
      myUserHive.value.save();
      update([GetConst.addFavorite, GetConst.syncContactsBuilder]);
    }
  }

  void deleteContact({
    required Contact contact,
  }) {
    try {
      myUserHive.value.contacts.removeWhere((e) => e.id == contact.id);
      myUserHive.value.save();
      Get.back();
      Get.closeAllSnackbars();
      Get.snackbar('${contact.firstName} ${contact.lastName}', 'has been deleted!', snackPosition: SnackPosition.BOTTOM, icon: Icon(Icons.check_circle, color: Colors.green));
    } catch (_) {}
    update([GetConst.addFavorite, GetConst.syncContactsBuilder]);
  }

  Future<void> syncContacts() async {
    try {
      ResponseOrError response = await PostmanRequest.getResponse();
      if (response.response != null) {
        List<Contact> favoritedContacts = myUserHive.value.contacts.where((e) => e.isFavorite).toList();
        myUserHive.value.contacts = response.response!.data!.toList();
        for (var e in myUserHive.value.contacts) {
          if (favoritedContacts.indexWhere((element) => element.id == e.id) != -1) {
            e.isFavorite = true;
          }
        }
        await myUserHive.value.save();
        Get.closeAllSnackbars();
        Get.snackbar('Contacts', 'Synced!', snackPosition: SnackPosition.BOTTOM, icon: Icon(Icons.check_circle, color: Colors.green));
        update([GetConst.syncContactsBuilder]);
      } else {
        Get.dialog(ErrorDialog(icon: Icons.warning, text1: 'Unable to sync contacts', text2: response.anyError!));
      }
    } catch (e) {
      debugPrint('ERROR syncContacts() : $e');
      Get.dialog(ErrorDialog(icon: Icons.warning, text1: 'Unable to sync contacts', text2: e.toString()));
    }
  }

  void changeThemeMode({
    required ThemeMode themeMode
  }) {
    Get.changeThemeMode(themeMode);
    myUserHive.value.themeModeString = themeMode.name;
    myUserHive.value.save();
    update([GetConst.changeThemeMode]);
  }
}