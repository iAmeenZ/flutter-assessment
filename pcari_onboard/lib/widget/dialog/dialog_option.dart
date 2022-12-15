import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_button.dart';

class OptionDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String text1;
  final VoidCallback onTap1;
  final IconData? titleIcon;
  final IconData? icon1;
  final IconData? icon2;
  final bool? isButton2Decoration;
  final Color? titleIconColor;
  final String? text2;
  final VoidCallback? onTap2;
  final Widget? subtitleWidget;
  final bool? isAvoidPop;
  const OptionDialog({Key? key, required this.title, this.isAvoidPop, this.titleIconColor, this.titleIcon, this.text2, this.subtitleWidget, this.icon1, this.icon2, this.isButton2Decoration, this.onTap2, this.subtitle, required this.onTap1, required this.text1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => isAvoidPop == null || !isAvoidPop!,
      child: Dialog(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 500
          ),
          padding: isButton2Decoration != null && !isButton2Decoration! ? EdgeInsets.fromLTRB(20, 20, 20, 5) : EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (titleIcon != null)...[
                          Icon(titleIcon, size: 30, color: titleIconColor),
                          SizedBox(width: 10)
                        ],
                        Expanded(child: Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                  Material(color: Colors.transparent, child: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close)))
                ],
              ),
              SizedBox(height: 10),
              if (subtitle != null)...[
                Text(subtitle!, style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 15)),
                SizedBox(height: 10),
              ],
              if (subtitleWidget != null)...[
                subtitleWidget!,
                SizedBox(height: 10),
              ],
              CustomButton(
                color: Theme.of(context).primaryColor,
                borderRadius: 10,
                margin: EdgeInsets.only(top: 10),
                splashColor: Colors.white.withOpacity(0.8),
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                shadowColor: Theme.of(context).primaryColor.withOpacity(0.2),
                onTap: onTap1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon1 != null)...[
                      Icon(icon1, color: Colors.white.withOpacity(0.9)),
                      SizedBox(width: 10),
                    ],
                    Text(text1, style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              if (text2 != null)...[
                isButton2Decoration == null || isButton2Decoration! ? CustomButton(
                  color: Theme.of(context).primaryColor,
                  borderRadius: 10,
                  splashColor: Colors.white.withOpacity(0.8),
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  shadowColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  onTap: onTap2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon2 != null)...[
                        Icon(icon2, color: Colors.white.withOpacity(0.9)),
                        SizedBox(width: 10),
                      ],
                      Text(text2!, style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.bold)),
                    ],
                  ),
                ) : Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: TextButton(
                    onPressed: onTap2,
                    child: Text(text2!)
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}