import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pcari_onboard/constants/custom_icon_icons.dart';
import 'package:pcari_onboard/model/contact.dart';
import 'package:pcari_onboard/services/controller/controller.dart';
import 'package:pcari_onboard/widget/custom_button.dart';
import 'package:pcari_onboard/widget/dialog/dialog_error.dart';
import 'package:pcari_onboard/widget/loading_page.dart';

class EditProfile extends StatefulWidget {
  final Contact contact;
  final Function(Contact) callback;
  const EditProfile({super.key, required this.contact, required this.callback});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  late Contact newContact = widget.contact;

  @override
  void dispose() {
    super.dispose();
    widget.callback(newContact);
  }
  
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

            SizedBox(height: 48),
            
            GestureDetector(
              onTap: () {
                captureAndSaveImage(id: widget.contact.id);
              },
              child: Center(
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
                    Positioned(
                      right: 13,
                      bottom: 4,
                      child: CustomButton(
                        margin: EdgeInsets.zero,
                        isShadow: false,
                        padding: EdgeInsets.all(5),
                        borderRadius: 300,
                        color: Get.theme.primaryColor,
                        child: Icon(CustomIcons.pencil_1, color: Colors.white, size: 12)
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 15),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(margin: EdgeInsets.only(left: 20, bottom: 5), child: Text('First Name', style: TextStyle(fontSize: 13, color: Get.theme.primaryColor))),
                  TextFormField(
                    initialValue: newContact.firstName,
                    onChanged: (val) {
                      newContact.firstName = val;
                    },
                  ),

                  SizedBox(height: 20),

                  Container(margin: EdgeInsets.only(left: 20, bottom: 5), child: Text('Last Name', style: TextStyle(fontSize: 13, color: Get.theme.primaryColor))),
                  TextFormField(
                    initialValue: newContact.lastName,
                    onChanged: (val) {
                      newContact.lastName = val;
                    },
                  ),

                  SizedBox(height: 20),

                  Container(margin: EdgeInsets.only(left: 20, bottom: 5), child: Text('Email', style: TextStyle(fontSize: 13, color: Get.theme.primaryColor))),
                  TextFormField(
                    initialValue: newContact.email,
                    onChanged: (val) {
                      newContact.email = val;
                    },
                  ),

                  SizedBox(height: 30),

                  CustomButton(
                    color: Get.theme.primaryColor,
                    borderRadius: 30,
                    isShadow: false,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.zero,
                    onTap: () {
                      MyController.to.editProfile(contact: newContact);
                      Get.close(1);
                    },
                    child: Text('Done', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                  )
                ]
              )
            ),

            

          ],
        ),
      ),
    );
  }

  void captureAndSaveImage({
    required int id
  }) async {
    Get.dialog(LoadingPage());
    try {
      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final Directory directory = await getApplicationDocumentsDirectory();
        final String directoryPath = '${directory.path}/$id.png';
        await image.saveTo(directoryPath);
        newContact.path = directoryPath;
        MyController.to.editProfile(contact: newContact);
        setState(() {});
      }
      Get.close(1);
    } catch (e) {
      debugPrint('ERROR captureAndSaveImage() : $e');
      Get.close(1);
      Get.dialog(ErrorDialog(icon: Icons.warning, text1: 'Unable to upload image', text2: e.toString()));
    }
  }

}