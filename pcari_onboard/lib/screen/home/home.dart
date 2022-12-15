import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcari_onboard/constants/constants.dart';
import 'package:pcari_onboard/constants/custom_icon_icons.dart';
import 'package:pcari_onboard/model/contact.dart';
import 'package:pcari_onboard/screen/favorite/add_favorite.dart';
import 'package:pcari_onboard/screen/home/contact_list.dart';
import 'package:pcari_onboard/screen/home/dialog_theme.dart';
import 'package:pcari_onboard/services/getx/controller.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('My Contacts', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(DialogThemeSetting());
            },
            tooltip: 'Theme Mode',
            icon: Icon(Icons.dark_mode)
          ),
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
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.grey.shade300,
              height: 80,
              child: Center(
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(25, 10, 20, 10),
                      hintText: 'Search Contact',
                      labelStyle: TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
                      suffixIcon: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: IconButton(
                          iconSize: 20,
                          onPressed: () {
                            debugPrint('Gegenpressing!');
                          },
                          icon: Icon(CustomIcons.search_1, color: Colors.grey)
                        ),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          width: 2,
                          color: Get.theme.primaryColor,
                          style: BorderStyle.solid,
                        )
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        )
                      )
                    ),
                    onChanged: (val) {
                      search = val;
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
                    color: isAll ? Get.theme.primaryColor : Colors.white,
                    onTap: () {
                      setState(() {
                        isAll = true;
                      });
                    },
                    child: Text('All', style: GoogleFonts.poppins(color: isAll ? Colors.white : null))
                  ),
                  CustomButton(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    shadowRadius: 1,
                    borderRadius: 5,
                    color: isAll ? Colors.white : Get.theme.primaryColor,
                    onTap: () {
                      setState(() {
                        isAll = false;
                      });
                    },
                    child: Text('Favorite', style: GoogleFonts.poppins(color: isAll ? null : Colors.white))
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