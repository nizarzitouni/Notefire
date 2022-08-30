// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:note_fire/app_router.dart';
import 'package:note_fire/core/constants.dart';
import 'package:note_fire/core/my_colors.dart';

class NoteFireApp extends StatelessWidget {
  NoteFireApp({
    Key? key,
    required this.isLogin,
  }) : super(key: key);
  final bool isLogin;
  final ColorScheme redSchemeDark = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: MyColors.myYellow,
    primary: MyColors.myOrange,
    secondary: MyColors.myOrange,
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Note Fire App',
      // theme: ThemeData.from(
      //   colorScheme: redSchemeDark,
      //   textTheme: TextTheme(
      //     headline1: TextStyle(color: Colors.white),
      //     headline2: TextStyle(color: Colors.white),
      //     bodyText1: TextStyle(color: Colors.white),
      //     bodyText2: TextStyle(color: Colors.white),
      //   ),
      // ),

      initialRoute: isLogin ? homeScreen : welcomePage,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }

  // MaterialColor buildMaterialColor(Color color) {
  //   List strengths = <double>[.05];
  //   Map<int, Color> swatch = {};
  //   final int r = color.red, g = color.green, b = color.blue;

  //   for (int i = 1; i < 10; i++) {
  //     strengths.add(0.1 * i);
  //   }
  //   strengths.forEach((strength) {
  //     final double ds = 0.5 - strength;
  //     swatch[(strength * 1000).round()] = Color.fromRGBO(
  //       r + ((ds < 0 ? r : (255 - r)) * ds).round(),
  //       g + ((ds < 0 ? g : (255 - g)) * ds).round(),
  //       b + ((ds < 0 ? b : (255 - b)) * ds).round(),
  //       1,
  //     );
  //   });
  //   return MaterialColor(color.value, swatch);
  // }
}
