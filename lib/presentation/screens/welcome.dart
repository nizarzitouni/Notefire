import 'package:flutter/material.dart';
import '../../core/my_colors.dart';

import '../../core/constants.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Welcome!',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: MyColors.white.withOpacity(.9)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 32, bottom: 16),
                  decoration: BoxDecoration(
                    color: MyColors.myOrange,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  width: 250,
                  child: TextButton(
                    child: Text('Sign In',
                        style: TextStyle(
                            fontSize: 20,
                            color: MyColors.white.withOpacity(.9))),
                    onPressed: () {
                      Navigator.of(context).pushNamed(signInScreen);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0, bottom: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.myOrange),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  width: 250,
                  child: TextButton(
                    child: Text('Sign Up',
                        style:
                            TextStyle(fontSize: 20, color: MyColors.myOrange)),
                    onPressed: () {
                      Navigator.of(context).pushNamed(signUpScreen);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Language : ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: MyColors.white.withOpacity(.6)),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'English',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: MyColors.myYellow),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
