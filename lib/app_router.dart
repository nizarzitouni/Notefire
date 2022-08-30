import 'package:flutter/material.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/welcome.dart';
import 'core/constants.dart';
import 'presentation/screens/add_note.dart';
import 'presentation/screens/sign_in.dart';
import 'presentation/screens/sign_up.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomePage:
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case signInScreen:
        return MaterialPageRoute(builder: (_) => SignIn());
      case signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUp());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case addNote:
        return MaterialPageRoute(builder: (_) => AddNote());
    }
    return null;
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text(
            'ERROR',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
        ),
      );
    });
  }
}
