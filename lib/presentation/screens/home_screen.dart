// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_fire/core/constants.dart';
import 'package:note_fire/core/my_colors.dart';
import 'package:note_fire/core/size_config.dart';
import 'package:note_fire/presentation/widgets/note_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  CollectionReference noteRef = FirebaseFirestore.instance.collection("notes");

  getUser() {
    User? user = FirebaseAuth.instance.currentUser!;
    debugPrint('---------------------- ${user.email}----------------------');
  }

  @override
  void initState() {
    //getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      //extendBodyBehindAppBar: true, //so background takes all the screen
      backgroundColor: bgColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.myOrange,
        onPressed: () {
          Navigator.of(context).pushNamed(addNote);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Image.asset(
              'assets/icons/icons8-firebase-48.png',
              width: SizeConfig.screenWidth * 0.07,
              height: SizeConfig.screenHeight * 0.07,
            ),
            SizedBox(width: 8.0),
            Text(
              "Home",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: MyColors.myYellow,
              ),
            ),
            Text(
              ' Page',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: MyColors.myOrange,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed(welcomePage);
              },
              icon: Icon(
                Icons.logout,
                color: MyColors.myYellow,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: myBody(),
      ),
    );
  }

  Widget myBody() {
    return Container(
      padding: EdgeInsets.all(8),
      child: FutureBuilder<QuerySnapshot>(
          //noteRef.get(), return query snapshot inside of it docs
          future: noteRef
              .where("user_id",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (context, var snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              debugPrint(
                  '----------------------ConnectionState=waiting----------------------');
              return Center(
                child: const CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasError) {
              debugPrint('snapshot hasError!');
              return Text(
                snapshot.error.toString(),
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              );
            }
            //snapshot has noErro
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return NoteTile(
                        noteTitile:
                            snapshot.data!.docs[index]["title"].toString(),
                        noteBody:
                            snapshot.data!.docs[index]["note"].toString());
                  });
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/undraw_empty.svg',
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Center(
                    child: Text(
                      'There is no notes try adding some !!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: white,
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  Future<QuerySnapshot<Object?>> _getNotes() {
    return noteRef
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  Widget getBody() {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.only(bottom: 50),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              width: SizeConfig.screenWidth,
              height: 45,
              decoration: BoxDecoration(
                  color: cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                    )
                  ],
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              //drawer here
                              //_drawerKey.currentState!.openDrawer();
                            },
                            child: Icon(
                              Icons.menu,
                              color: white.withOpacity(0.7),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
