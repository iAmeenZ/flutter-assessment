import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pcari_onboard/screen/home/home.dart';
import 'package:pcari_onboard/services/controller/controller.dart';

import 'constants/theme.dart';
import 'constants/theme_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // STATUS BAR
      statusBarColor: Colors.transparent,
      systemStatusBarContrastEnforced: false,
      // iOS only
      statusBarBrightness: Brightness.dark,
      // Android only
      statusBarIconBrightness: Brightness.dark,
      
      // BOTTOM NAVIGATION
      systemNavigationBarColor: Colors.transparent,
      // systemNavigationBarDividerColor: Colors.transparent, // DON'T USE THIS (CAUSING statusBarText can't change)
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarContrastEnforced: false
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top]);
  }
  await Hive.initFlutter();
  await MyController().initHiveAndGetX();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const ScrollBehavior().copyWith(physics: const BouncingScrollPhysics(), overscroll: false),
      initialRoute: '/',
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: currentThemeMode(),
      getPages: [
        GetPage(name: '/', page: () => HomeScreen())
      ],
      defaultTransition: Transition.fadeIn,
      debugShowCheckedModeBanner: false,
    );
  }
}