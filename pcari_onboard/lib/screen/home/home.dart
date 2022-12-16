import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcari_onboard/constants/constants.dart';
import 'package:pcari_onboard/constants/custom_icon_icons.dart';
import 'package:pcari_onboard/model/contact.dart';
import 'package:pcari_onboard/screen/favorite/add_favorite.dart';
import 'package:pcari_onboard/screen/home/contact_list.dart';
import 'package:pcari_onboard/screen/home/dialog_theme.dart';
import 'package:pcari_onboard/services/controller/controller.dart';
import 'package:pcari_onboard/widget/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isAll = true;
  String? search;

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('My Contacts'),
        leading: IconButton(
          onPressed: () {
            Get.dialog(DialogThemeSetting());
          },
          tooltip: 'Theme Mode',
          icon: Icon(Get.isDarkMode ? Icons.dark_mode : Icons.light_mode)
        ),
        actions: [
          RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
            child: IconButton(
              onPressed: () {
                animateRotationIcon();
                MyController.to.syncContacts();
              },
              tooltip: 'Sync Contacts',
              icon: Icon(Icons.sync)
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddFavorite());
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Get.theme.cardColor,
              height: 80,
              child: Center(
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Get.theme.scaffoldBackgroundColor,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(25, 10, 20, 10),
                      hintText: 'Search Contact',
                      hintStyle: TextStyle(fontSize: 15, color: Get.isDarkMode ? Colors.white : Colors.grey),
                      suffixIcon: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(CustomIcons.search_1, color: Colors.grey.shade400, size: 18)
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          width: 2,
                          color: Get.theme.primaryColor,
                          style: BorderStyle.solid,
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        )
                      )
                    ),
                    onChanged: (val) {
                      if (val.isEmpty) {
                        search = null;
                      } else {
                        search = val;
                      }
                      setState(() {});
                    },
                  ),
                ),
              )
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  CustomButton(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    borderRadius: 5,
                    shadowRadius: 1,
                    color: isAll ? Get.theme.primaryColor : Get.theme.scaffoldBackgroundColor,
                    onTap: () {
                      setState(() {
                        isAll = true;
                      });
                    },
                    child: Text('All', style: GoogleFonts.poppins(color: isAll ? Colors.white : Colors.grey.shade600))
                  ),
                  CustomButton(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    shadowRadius: 1,
                    borderRadius: 5,
                    color: isAll ? Get.theme.scaffoldBackgroundColor : Get.theme.primaryColor,
                    onTap: () {
                      setState(() {
                        isAll = false;
                      });
                    },
                    child: Text('Favorite', style: GoogleFonts.poppins(color: isAll ? Colors.grey.shade600 : Colors.white))
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            GetBuilder<MyController>(
              id: GetConst.syncContactsBuilder,
              builder: (myController) {
                List<Contact> contactList = myController.myUserHive.value.contacts.toList();
                if (!isAll) {
                  contactList.removeWhere((e) => !e.isFavorite);
                }
                if (search != null) {
                  List<Contact> newList = [];
                  for (var e in contactList) {
                    String combined = '${e.firstName.toLowerCase()} ${e.lastName.toLowerCase()} ${e.email.toLowerCase()}';
                    if (combined.contains(search!.toLowerCase())) {
                      newList.add(e);
                    }
                  }
                  contactList = newList.toList();
                }
                return ContactList(
                  isAll: isAll,
                  contacts: contactList
                );
              }
            )

          ],
        ),
      ),
    );
  }

  void animateRotationIcon() async {
    _controller.forward();
    await Future.delayed(Duration(seconds: 1));
    _controller.reset();
  }

}