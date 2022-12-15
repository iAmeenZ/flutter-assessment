import 'package:flutter/material.dart';

class MyTheme {

  static const color1 = Colors.redAccent;
  static const color2 = Colors.red;

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.grey.shade800,
    cardColor: Colors.grey.shade800,
    
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      background: Colors.grey.shade900,
      onBackground: Colors.grey.shade600,
      primary: Colors.white.withOpacity(0.9),
      onPrimary: Colors.white.withOpacity(0.5),
      secondary: Colors.white.withOpacity(0.9),
      onSecondary: Colors.white.withOpacity(0.5),
      error: Colors.red,
      onError: Colors.red,
      surface: Colors.grey.shade900,
      onSurface: Colors.grey.shade600
    ),

    
    iconTheme: const IconThemeData(color: Colors.white),
    listTileTheme: ListTileThemeData(iconColor: Colors.white.withOpacity(0.85), textColor: Colors.white.withOpacity(0.85)),
    dividerColor: Colors.white.withOpacity(0.9),
    shadowColor: Colors.black.withOpacity(0.5),
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(
    //     primary: Colors.white.withOpacity(0.9),
    //   ),
    // ),

    dividerTheme: DividerThemeData(color: Colors.grey.shade100),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(),
    ).apply(
      bodyColor: Colors.white.withOpacity(0.9), 
      //displayColor: Colors.blue, 
    ),

    // inputDecorationTheme: InputDecorationTheme(
    //   border: InputBorder.none,
    //   prefixIconColor: Colors.white.withOpacity(0.9),
    //   hintStyle: TextStyle(color: Colors.grey.shade600),
    //   suffixIconColor: Colors.white.withOpacity(0.9),
    // ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.transparent,
      filled: true,
      floatingLabelStyle: TextStyle(color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.bold),
      focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
      errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade600, width: 2)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: color1, width: 2)),
      prefixIconColor: Colors.white.withOpacity(0.9),
      suffixIconColor: Colors.white.withOpacity(0.8)
    ),
    
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.white.withOpacity(0.9),
      selectionColor: Colors.red
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey.shade800,
      foregroundColor: Colors.white.withOpacity(0.9)
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 20, 20, 20)
    )
  );



  
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: Colors.grey.shade100,
    primaryColor: color1,
    cardColor: Colors.white,

    colorScheme: ColorScheme.light().copyWith(primary: color2),
  
    iconTheme: IconThemeData(color: Colors.black.withOpacity(0.9)),
    listTileTheme: ListTileThemeData(iconColor: Colors.black.withOpacity(0.8)),
    shadowColor: Colors.grey.withOpacity(0.5),
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(
    //     primary: Colors.black.withOpacity(0.9),
    //   ),
    // ),

    dividerTheme: DividerThemeData(color: Colors.grey.shade700),

    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black.withOpacity(0.9)),
      bodyMedium: TextStyle(),
    ).apply(
      bodyColor: Colors.black.withOpacity(0.9),
      //displayColor: Colors.blue, 
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.transparent,
      filled: true,
      floatingLabelStyle: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
      errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: color2, width: 2)),
      prefixIconColor: Colors.black.withOpacity(0.9),
      suffixIconColor: Colors.black.withOpacity(0.8)
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black87,
      selectionColor: Colors.red
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: color2,
      foregroundColor: Colors.black.withOpacity(0.9)
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent
    )
  );

  
}
