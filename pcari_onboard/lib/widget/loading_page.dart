import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  final bool? isOrangeAccent;
  const LoadingPage({Key? key, this.isOrangeAccent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        color: Colors.transparent,
        child: Center(child: customSpinkit(isRedAccent: isOrangeAccent)),
      ),
    ); 
  }
}

Widget customSpinkit({bool? isRedAccent}) {
  return SpinKitDualRing(color: isRedAccent != null && isRedAccent ? Colors.orangeAccent : Colors.white, size: 130);
}