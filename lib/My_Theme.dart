import 'package:flutter/material.dart';

class MyTheme{
  static Color PrimaryLight = Color(0xff5D9CEC);
  static Color backgroundLigth = Color(0xffDFECDB);
  static Color backgroundDark = Color(0xff060E1E);
  static Color greenlight = Color(0xff61E757);
  static Color white = Colors.white;
  static Color blackColor = Color(0xff383838);
  static Color redColor = Color(0xffEC4B4B);
  static Color greyColor = Color(0xffC8C9CB);
  static Color CalenderDarkColor = Color(0xff141922);
  static ThemeData lightMode = ThemeData(
    primaryColor: PrimaryLight,
    scaffoldBackgroundColor: backgroundLigth,
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: white),
        titleTextStyle: TextStyle(color: white),),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor:PrimaryLight ,unselectedItemColor:greyColor,
        showUnselectedLabels: true,showSelectedLabels: true,backgroundColor: Colors.transparent,elevation: 0),
    textTheme: TextTheme(subtitle1: TextStyle(fontSize: 20,
      color: blackColor,
    ),
      headline1: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
        subtitle2: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)

    ),
    bottomSheetTheme: BottomSheetThemeData(shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))))
  );
  static ThemeData DarktMode = ThemeData(
      primaryColor: PrimaryLight,
      scaffoldBackgroundColor: backgroundDark,
      appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: blackColor),
          titleTextStyle: TextStyle(color: blackColor)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor:PrimaryLight ,unselectedItemColor:greyColor,
          showUnselectedLabels: true,showSelectedLabels: true,backgroundColor: Colors.transparent,elevation: 0),
      textTheme: TextTheme(subtitle1: TextStyle(fontSize: 20,
        color: blackColor,
      ),
          headline1: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
          subtitle2: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)

      ),
      bottomSheetTheme: BottomSheetThemeData(shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))))
  );

}