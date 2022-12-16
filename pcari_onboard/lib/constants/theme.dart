import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {

  static const primaryColor = Color.fromRGBO(50, 185, 164, 1);
  static const primaryColorLight = Color.fromRGBO(235, 248, 246, 1);
  static const primaryColorDark = Color.fromARGB(255, 39, 144, 128);

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: Colors.black,
    primaryColor: primaryColor,
    cardColor: Colors.grey.shade900,

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade800,
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      titleTextStyle: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19)
    ),
    
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

    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.transparent,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(25, 10, 20, 10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          width: 1,
          color: primaryColor,
          style: BorderStyle.solid,
        )
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          width: 1,
          color: primaryColor,
          style: BorderStyle.solid,
        )
      )
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

    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    primaryColorLight: primaryColorLight,
    primaryColorDark: primaryColorDark,
    cardColor: Colors.grey.shade300,

    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      titleTextStyle: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19)
    ),

    colorScheme: ColorScheme.light().copyWith(primary: primaryColor),
  
    iconTheme: IconThemeData(color: Colors.black.withOpacity(0.9)),
    listTileTheme: ListTileThemeData(iconColor: Colors.black.withOpacity(0.8)),
    shadowColor: Colors.grey.withOpacity(0.5),

    dividerTheme: DividerThemeData(color: Colors.grey.shade700),

    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black.withOpacity(0.9)),
      bodyMedium: TextStyle(),
    ).apply(
      bodyColor: Colors.black.withOpacity(0.9),
      //displayColor: Colors.blue, 
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(25, 10, 20, 10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          width: 1,
          color: primaryColor,
          style: BorderStyle.solid,
        )
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          width: 1,
          color: primaryColor,
          style: BorderStyle.solid,
        )
      )
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black87,
      selectionColor: Colors.red
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
    )
  );

  
}
