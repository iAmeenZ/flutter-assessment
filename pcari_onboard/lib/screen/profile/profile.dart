import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcari_onboard/constants/custom_icon_icons.dart';
import 'package:pcari_onboard/model/contact.dart';
import 'package:pcari_onboard/screen/profile/edit_profile.dart';
import 'package:pcari_onboard/services/http/send_email.dart';
import 'package:pcari_onboard/widget/custom_button.dart';

class Profile extends StatefulWidget {
  final Contact contact;
  const Profile({super.key, required this.contact});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late Contact newContact = widget.contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          constraints: BoxConstraints(),
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios)
        ),
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.to(() => EditProfile(
                      contact: newContact,
                      callback: (e) {
                        WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
                          newContact = e;
                        }));
                      },
                    ));
                  },
                  child: Text('Edit', style: TextStyle(color: Get.theme.primaryColor))
                ),
                SizedBox(width: 10)
              ]
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Get.theme.primaryColor,
                        width: 5,
                      ),
                    ),
                    child: FittedBox(
                      child: newContact.path != null ? CircleAvatar(
                        radius: 60.0,
                        backgroundImage:  FileImage(File(newContact.path!)),
                        backgroundColor: Colors.transparent
                      ) : CircleAvatar(
                        radius: 60.0,
                        backgroundImage: CachedNetworkImageProvider(widget.contact.avatar),
                        backgroundColor: Colors.transparent
                      ),
                    ),
                  ),
                  if (newContact.isFavorite)...[
                    Positioned(
                      right: 10,
                      bottom: 0,
                      child: Icon(Icons.star, color: Colors.yellow.shade700, size: 30)
                    )
                  ]
                ]
              )
            ),

            SizedBox(height: 15),

            Text('${newContact.firstName} ${newContact.lastName}', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),

            SizedBox(height: 15),
            
            Container(
              color: Get.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
              height: 80,
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Stack(
                    children: [
                      Positioned(
                        bottom: 10,
                        left: 5,
                        child: Container(
                          color: Get.theme.scaffoldBackgroundColor,
                          height: 25,
                          width: 35,
                          child: Container()
                        )
                      ),
                      Icon(CustomIcons.mail, color: Get.theme.primaryColor, size: 45),
                    ]
                  ),
                  SizedBox(height: 3),
                  Text(newContact.email, style: TextStyle(fontSize: 13))
                ]
              )
            ),

            SizedBox(height: 15),

            CustomButton(
              color: Get.theme.primaryColor,
              borderRadius: 30,
              isShadow: false,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              onTap: () {
                sendEmail(contact: newContact);
              },
              child: Text('Send Email', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
            )

          ],
        ),
      ),
    );
  }
}