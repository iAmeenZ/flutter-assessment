import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customLinearProgressIndicator({bool? isWhite}) {
  return LinearProgressIndicator(backgroundColor: Colors.transparent, color: isWhite != null && isWhite ? Colors.white : Get.theme.primaryColor);
}