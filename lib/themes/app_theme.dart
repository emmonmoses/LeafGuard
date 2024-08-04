import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //// COLORS
  static Color red = Colors.red;
  static Color grey = Colors.grey;
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color green = Colors.green;
  // static Color main = const Color(0xff5c50dc);
  static Color main = green;
  static const Color defaultTextColor = Colors.black;
  static Color bgSideMenu = const Color(0xff131e29);
  static Color dividerColor = const Color(0xFF424242);
  static Color bgWhiteMixin = const Color(0xfff8f7f3);

  static const label = Color.fromARGB(255, 148, 235, 34);
  static const primary = Color(0xff262626);
  static const secondaryBg = Color(0xffececf6);
  static const secondary = Color(0xffa6a6a6);
  //// SIZES
  static const avatarSize = 30.0;
  static const sizebutton = 14.0;
  static const sizecaption = 12.0;
  static const sizeoverline = 10.0;
  static const sizeBoxSpace = 30.0;
  static const fontSize = 12.0;
  static const sizeBoxSpace2 = 15.0;
  static const fabSizeBoxSpace = 16.0;
  static const sizeheadline6 = 15.0;
  static const sizesubtitle2 = 14.0;
  static const sizebodyText2 = 14.0;
  static const sizeBoxHeight = 200.0;
  static const sizeBoxWidth = 10.0;
  static const dividerThickness = 0.5;
  static const kDefaultPadding = 20.0;

  static ThemeData theming(context) {
    return ThemeData.light().copyWith(
      dividerColor: dividerColor,
      primaryColor: main,
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(grey),
        trackVisibility: WidgetStateProperty.all(false),
        thickness: WidgetStateProperty.all(4),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          titleMedium: TextStyle(
            fontSize: sizeheadline6,
            fontWeight: FontWeight.bold,
            color: defaultTextColor,
          ),
          titleSmall: TextStyle(
            fontSize: sizesubtitle2,
            fontWeight: FontWeight.bold,
            color: defaultTextColor,
          ),
          bodyLarge: TextStyle(
            color: defaultTextColor,
          ),
          bodyMedium: TextStyle(
            fontSize: sizebodyText2,
            color: defaultTextColor,
          ),
          labelLarge: TextStyle(
            fontSize: sizebutton,
            fontWeight: FontWeight.bold,
            color: defaultTextColor,
          ),
          bodySmall: TextStyle(
            fontSize: sizecaption,
            color: defaultTextColor,
          ),
          labelSmall: TextStyle(
            fontSize: sizeoverline,
            color: defaultTextColor,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith(
            (state) {
              if (state.contains(WidgetState.disabled)) {
                return grey;
              }
              return main;
            },
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          backgroundColor: main,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: TextStyle(color: white),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          backgroundColor: main,
        ),
      ),
      iconTheme: IconThemeData(
        color: black,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        expandedAlignment: Alignment.centerRight,
        collapsedIconColor: main,
      ),
      colorScheme: Theme.of(context)
          .colorScheme
          .copyWith(primary: main)
          .copyWith(surface: bgWhiteMixin),
      // inputDecorationTheme: const InputDecorationTheme(
      //   isDense: true,
      //   focusedBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.blue),
      //   ),
      //   enabledBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.grey),
      //   ),
      //   labelStyle: TextStyle(
      //     color: defaultTextColor,
      //   ),
      // ),
    );
  }
}
