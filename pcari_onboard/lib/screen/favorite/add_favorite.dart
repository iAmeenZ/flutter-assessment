import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcari_onboard/constants/constants.dart';
import 'package:pcari_onboard/constants/custom_icon_icons.dart';
import 'package:pcari_onboard/services/getx/controller.dart';

class AddFavorite extends StatelessWidget {
  const AddFavorite({super.key});

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
        child: GetBuilder<MyController>(
          id: GetConst.addFavorite,
          builder: (myController) {
            return Column(
              children: myController.myUserHive.value.contacts.map((e) => ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 30),
                leading: CircleAvatar(
                  radius: 27,
                  backgroundImage: CachedNetworkImageProvider(e.avatar),
                ),
                title: Text(e.firstName, style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
                subtitle: Text(e.email, style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                trailing: IconButton(
                  icon: e.isFavorite ? Icon(Icons.star, color: Colors.yellow.shade700) : Icon(Icons.star_border, color: Colors.grey),
                  onPressed: () {
                    MyController.to.addFavorite(id: e.id);
                  },
                ),
                focusColor: Get.theme.primaryColorLight,
                splashColor: Get.theme.primaryColorLight,
                onTap: () {
                  MyController.to.addFavorite(id: e.id);
                }
              )).toList()
            );
          }
        ),
      )
    );
  }
}