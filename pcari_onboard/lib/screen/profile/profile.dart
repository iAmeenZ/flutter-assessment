import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcari_onboard/constants/custom_icon_icons.dart';
import 'package:pcari_onboard/model/contact.dart';

class Profile extends StatelessWidget {
  final Contact contact;
  const Profile({super.key, required this.contact});

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
          icon: Icon(Icons.arrow_back_ios, color: Colors.white)
        ),
        centerTitle: true,
        title: Text('Add to Favorite', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
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

                  },
                  child: Text('Edit', style: TextStyle(color: Get.theme.primaryColor))
                ),
                SizedBox(width: 10),
              ],
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
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: CachedNetworkImageProvider(contact.avatar),
                        backgroundColor: Colors.transparent
                      ),
                    ),
                  ),
                  if (contact.isFavorite)...[
                    Positioned(
                      right: 10,
                      bottom: 0,
                      child: Icon(Icons.star, color: Colors.yellow.shade700, size: 30)
                    )
                  ]
                ],
              ),
            ),

            SizedBox(height: 15),

            Text('${contact.firstName} ${contact.lastName}', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),

            SizedBox(height: 15),
            
            Container(
              color: Colors.grey.shade200,
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
                          color: Colors.white,
                          height: 25,
                          width: 35,
                          child: Container()
                        ),
                      ),
                      Icon(CustomIcons.mail, color: Get.theme.primaryColor, size: 45),
                    ],
                  ),
                  SizedBox(height: 3),
                  Text(contact.email, style: TextStyle(fontSize: 13))
                ],
              )
            ),

          ],
        ),
      ),
    );
  }
}