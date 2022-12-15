import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentDialog extends StatelessWidget {
  final String text1;
  final Widget content;
  final Widget? iconWidget;
  final bool? isAvoidPop;
  const ContentDialog({Key? key, required this.text1, this.isAvoidPop, required this.content, this.iconWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => isAvoidPop == null || !isAvoidPop!,
      child: Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (iconWidget != null)...[
                          iconWidget!,
                          SizedBox(width: 10),
                        ],
                        Expanded(child: Text(text1, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                  if (isAvoidPop == null || !isAvoidPop!)...[
                    Material(color: Colors.transparent, child: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close)))
                  ]
                ],
              ),
              SizedBox(height: 10),
              content,
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}