import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorDialog extends StatelessWidget {
  final String text1;
  final String text2;
  final IconData? icon;
  const ErrorDialog({Key? key, required this.text1, required this.text2, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (icon != null)...[
                        Icon(icon, size: 25),
                        SizedBox(width: 10),
                      ],
                      Expanded(child: Text(text1, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                Material(color: Colors.transparent, child: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close)))
              ],
            ),
            SizedBox(height: 10),
            Text(text2),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}