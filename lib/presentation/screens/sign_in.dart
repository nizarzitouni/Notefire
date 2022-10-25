// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_fire/core/constants.dart';
import 'package:note_fire/core/my_colors.dart';
import 'package:note_fire/core/size_config.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late String myUsername, myEmail, myPassword;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.bgColor,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: SizeConfig.screenHeight * 0.5,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 25.0,
                  )
                ],
                color: MyColors.bgColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                )),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Container(
                    //   margin: EdgeInsets.all(16),
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       'Sign In',
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: TextButton(
                        onPressed: () => _signUpPage(context),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            color: MyColors.myOrange.withOpacity(.9),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    'Welcome back to Fire Notes.',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: MyColors.white.withOpacity(.9)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    'sign in with your informations',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: MyColors.white.withOpacity(.7)),
                  ),
                ),
                Form(
                  key: formstate,
                  child: Column(
                    children: [
                      //Email Input Field
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 24, bottom: 8),
                        child: TextFormField(
                          onSaved: (newValue) {
                            if (newValue != null) {
                              myEmail = newValue.trim();
                            }
                          },
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'email must not be empty';
                            }
                            if (value.length > 30) {
                              return "can't be more then 30 char";
                            }
                            if (value.length < 4) {
                              return "email is too short";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: 'E-Mail Address',
                            hintStyle: TextStyle(
                                color: MyColors.white.withOpacity(.5)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: MyColors.white.withOpacity(.5))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: MyColors.white.withOpacity(.5))),
                          ),
                        ),
                      ),
                      //Password Input Field
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        child: TextFormField(
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'password must not be empty';
                            }
                            if (value.length > 30) {
                              return "can't be more then 30 characters";
                            }
                            if (value.length < 6) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            if (newValue != null) {
                              myPassword = newValue.trim();
                            }
                          },
                          obscureText: true,
                          style: TextStyle(fontSize: 18),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: MyColors.white.withOpacity(.5)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: MyColors.white.withOpacity(.5))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: MyColors.white.withOpacity(.5))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 32, bottom: 16),
                    decoration: BoxDecoration(
                      color: MyColors.myOrange,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    width: 250,
                    child: TextButton(
                      child: Text('Sign In',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      onPressed: () async {
                        UserCredential? credential = await _dataValidation();
                        if (credential != null) {
                          Navigator.of(context).pop();
                          await Navigator.of(context)
                              .pushReplacementNamed(homeScreen);
                        } else {
                          debugPrint(
                              '----------------------Signip Failled----------------------');
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _signUpPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(signUpScreen);
  }

  customSnackBar(String action, String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: action,
          textColor: action == 'Error' ? Colors.white : Colors.white,
          onPressed: () {
            // Code to execute.
          },
        ),
        backgroundColor: action == 'Error' ? Colors.red : Colors.green,
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Center(child: Text(msg)),
        ),

        duration: const Duration(milliseconds: 2000),
        width: 280.0, // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Future<UserCredential?> _dataValidation() async {
    FormState? formData = formstate.currentState;
    if (formData!.validate()) {
      debugPrint('---------------------- Infos Valid----------------------');
      //trigger on save fucn in each button to save the values
      formData.save();
      UserCredential? credential = await _signIn();
      return credential;
    } else {
      debugPrint(
          '----------------------Infos are Not Valid----------------------');
      return null;
    }
  }

  Future<UserCredential?> _signIn() async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: myEmail, password: myPassword);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        customSnackBar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        customSnackBar('Error', 'Wrong password provided for that user.');
        debugPrint('Wrong password provided for that user.');
      }
    }
    return null;
  }
}
