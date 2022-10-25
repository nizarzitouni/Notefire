// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_fire/core/constants.dart';
import 'package:note_fire/core/my_colors.dart';
import 'package:note_fire/core/size_config.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
            height: SizeConfig.screenHeight * 0.7,
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
                    bottomRight: Radius.circular(32))),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(16),
                      child: TextButton(
                        onPressed: () => _signInPage(context),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 20,
                            color: MyColors.myOrange,
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.all(16),
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       'Sign Up',
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         color: Colors.green,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    'Welcome to Fire Notes.',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: MyColors.white.withOpacity(.9)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    'Let\'s get started',
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
                      //Name Input Field
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 32, bottom: 8),
                        child: TextFormField(
                          onSaved: (newValue) {
                            if (newValue != null) {
                              myUsername = newValue.trim();
                            }
                          },
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'name must not be empty';
                            }
                            if (value.length > 30) {
                              return "name can't be more then 30 char";
                            }
                            if (value.length < 4) {
                              return "name is too short";
                            }
                            return null;
                          },
                          style: TextStyle(
                              fontSize: 18,
                              color: MyColors.white.withOpacity(.8)),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            hintText: 'Name',
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
                      //Email Input Field
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
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
                          style: TextStyle(
                              fontSize: 18,
                              color: MyColors.white.withOpacity(.8)),
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
                          style: TextStyle(
                              fontSize: 18,
                              color: MyColors.white.withOpacity(.8)),
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
                      border: Border.all(color: MyColors.myOrange),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    width: 250,
                    child: TextButton(
                      child: Text('Sign Up',
                          style: TextStyle(
                              fontSize: 20, color: MyColors.myOrange)),
                      onPressed: () async {
                        var credential = await _signUp();
                        if (credential != null) {
                          //savingname and email to firestore
                          await FirebaseFirestore.instance
                              .collection('users')
                              .add({
                            "username": myUsername,
                            "email": myEmail,
                          });
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacementNamed(homeScreen);
                          // customSnackBar(
                          //     'Success', 'Go Sign In To  Your Account');
                        } else {
                          debugPrint(
                              '----------------------Signup Failled----------------------');
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

  _signInPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(signInScreen);
    // .whenComplete(() => setState(() {
    //       //dataFutur = fetch();
    //     }));
  }

// //Old data validation
//   _dataValidation() {
//     if (nameTextEditingController.text.isEmpty ||
//         passwordTextEditingController.text.isEmpty ||
//         emailTextEditingController.text.isEmpty) {
//       customSnackBar('Error', 'All fields must be full !');
//     } else {
//       _createUser();
//       //
//       //Navigator.of(context).pop();
//       //
//       customSnackBar('Success', 'Sign Up successful!');
//     }
//   }

  customSnackBar(String action, String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: action,
          textColor: action == 'Error' ? Colors.black : Colors.black,
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

  Future<UserCredential?> _signUp() async {
    FormState? formData = formstate.currentState;
    if (formData!.validate()) {
      debugPrint('---------------------- Infos Valid----------------------');
      //trigger on save fucn in each button to save the values
      formData.save();
      UserCredential? credential = await _createUser();
      return credential;
    } else {
      debugPrint(
          '----------------------Infos are Not Valid----------------------');
      return null;
    }
  }

  Future<UserCredential?> _createUser() async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: myEmail,
        password: myPassword,
      );
      customSnackBar('Seccess', 'Account Created Successfully');
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        customSnackBar('Error', 'Password is to weak');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        customSnackBar('Error', 'The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
