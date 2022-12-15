import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcari_onboard/constants/custom_icon_icons.dart';
import 'package:pcari_onboard/model/contact.dart';
import 'package:pcari_onboard/screen/profile/profile.dart';
import 'package:pcari_onboard/services/getx/controller.dart';
import 'package:pcari_onboard/widget/custom_button.dart';

class ContactList extends StatelessWidget {
  final bool isAll;
  final List<Contact> contacts;
  const ContactList({super.key, required this.isAll, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (contacts.isEmpty)...[
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 20),
            child: Image.asset('assets/image1.png'),
          ),
          Text('No list of contact here,\nadd contact now', textAlign: TextAlign.center, style: GoogleFonts.inter(fontWeight: FontWeight.bold))
        ] else...[
          Column(
            children: contacts.map((e) => Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    icon: CustomIcons.pencil_1,
                    foregroundColor: Colors.yellow.shade700,
                    backgroundColor: Get.theme.primaryColorLight,
                    onPressed: (context) {
                      
                    }
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: 2,
                    color: Get.theme.primaryColorLight,
                    child: Container(
                      color: Get.theme.primaryColorDark.withOpacity(0.2),
                    ),
                  ),
                  SlidableAction(
                    icon: CustomIcons.trash,
                    foregroundColor: Colors.red,
                    backgroundColor: Get.theme.primaryColorLight,
                    onPressed: (context) {
                      Get.dialog(Dialog(
                        child: SizedBox(
                          height: 130,
                          child: Column(
                            children: [
                              Container(padding: EdgeInsets.fromLTRB(40, 25, 40, 15), child: Text('Are you sure you want to delete this contact?', textAlign: TextAlign.center, style: GoogleFonts.inter(fontWeight: FontWeight.bold))),
                              Divider(height: 0, color: Colors.grey),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        height: double.infinity,
                                        borderRadius: 0,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        isShadow: false,
                                        color: Colors.transparent,
                                        onTap: () {
                                          MyController.to.deleteContact(contact: e);
                                        },
                                        child: Center(child: Text('Yes', textAlign: TextAlign.center, style: GoogleFonts.ubuntu(color: Colors.red)))
                                      ),
                                    ),
                                    VerticalDivider(color: Colors.grey, width: 0),
                                    Expanded(
                                      child: CustomButton(
                                        height: double.infinity,
                                        borderRadius: 0,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        isShadow: false,
                                        color: Colors.transparent,
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Center(child: Text('No', textAlign: TextAlign.center, style: GoogleFonts.ubuntu(color: Colors.green)))
                                      ),
                                    )
                                  ]
                                ),
                              )
                            ]
                          )
                        )
                      ));
                    }
                  )
                ]
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 30),
                leading: CircleAvatar(
                  radius: 27,
                  backgroundImage: CachedNetworkImageProvider(e.avatar),
                ),
                title: Row(
                  children: [
                    Flexible(child: Text('${e.firstName} ${e.lastName}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold))),
                    if (e.isFavorite)...[
                      SizedBox(width: 5),
                      Icon(Icons.star, color: Colors.yellow.shade700, size: 20)
                    ]
                  ],
                ),
                subtitle: Text(e.email, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                trailing: IconButton(
                  icon: Icon(CustomIcons.paper_plane_empty, color: Get.theme.primaryColor),
                  onPressed: () {

                  },
                ),
                focusColor: Get.theme.primaryColorLight,
                splashColor: Get.theme.primaryColorLight,
                onTap: () {
                  Get.to(() => Profile(contact: e));
                }
              ),
            )).toList()
          )
        ]
      ],
    );
  }
}