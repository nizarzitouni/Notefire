// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_fire/core/my_colors.dart';
import 'package:note_fire/core/size_config.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditNote extends StatefulWidget {
  final DocumentSnapshot noteSnapshot;
  //Map? dataMap;

  EditNote({
    Key? key,
    required this.noteSnapshot,
    //required this.dataMap,
  }) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  //Form fields
  late String noteTitle, noteBody, imageUrl;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  // late Reference ref;
  // //
  CollectionReference noteRefs = FirebaseFirestore.instance.collection("notes");
  //  Future<DocumentSnapshot<Object?>> _getDoc() async {
  //   return await noteRefs.doc(widget.docId).get();
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //Future<DocumentSnapshot<Object?>> note = _getDoc();
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Row(
          children: [
            Image.asset(
              'assets/icons/icons8-firebase-48.png',
              width: SizeConfig.screenWidth * 0.07,
              height: SizeConfig.screenHeight * 0.07,
            ),
            SizedBox(width: 8.0),
            Text(
              "UPDATE",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: MyColors.myYellow,
              ),
            ),
            Text(
              ' NOTE',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: MyColors.myOrange,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            //
            Form(
              key: formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: MyColors.white,
                      ),
                    ),
                  ),
                  //Name Input Field
                  Padding(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 8),
                    child: TextFormField(
                      onSaved: (newValue) {
                        if (newValue != null) {
                          noteTitle = newValue.trim();
                        }
                      },
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'note title must not be empty';
                        }
                        if (value.length > 30) {
                          return "note title can't be more then 30 char";
                        }
                        if (value.length < 4) {
                          return "note title is too short";
                        }
                        return null;
                      },
                      style: TextStyle(
                          fontSize: 15, color: MyColors.white.withOpacity(.8)),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      initialValue: widget.noteSnapshot["title"].toString(),
                      decoration: InputDecoration(
                        hintText: 'Note Title',
                        hintStyle:
                            TextStyle(color: MyColors.white.withOpacity(.6)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: MyColors.white.withOpacity(0.4))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: MyColors.white.withOpacity(0.4))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w400,
                        color: MyColors.white,
                      ),
                    ),
                  ),
                  //Email Input Field
                  Padding(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 8),
                    child: TextFormField(
                      maxLines: 6,
                      onSaved: (newValue) {
                        if (newValue != null) {
                          noteBody = newValue.trim();
                        }
                      },
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Note must not be empty';
                        }
                        if (value.length > 255) {
                          return "can't be more then 255 char";
                        }
                        if (value.length < 4) {
                          return "Note is too short";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontSize: 17, color: MyColors.white.withOpacity(.8)),
                      initialValue: widget.noteSnapshot["note"].toString(),
                      decoration: InputDecoration(
                        hintText: 'Write Your Note',
                        hintStyle:
                            TextStyle(color: MyColors.white.withOpacity(.6)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: MyColors.white.withOpacity(0.4))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: MyColors.white.withOpacity(0.4))),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 25, bottom: 16),
                      decoration: BoxDecoration(
                        color: MyColors.myOrange,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      width: SizeConfig.screenWidth * 0.8,
                      child: TextButton(
                        child: Text('UPDATE NOTE',
                            style:
                                TextStyle(fontSize: 17, color: MyColors.white)),
                        onPressed: () async {
                          //
                          await updateNote();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateNote() async {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      //trigger on save fucn in each button to save the values

      formData.save();
      await noteRefs.doc(widget.noteSnapshot.id).update({
        "title": noteTitle,
        "note": noteBody,
        "user_id": FirebaseAuth.instance.currentUser!.uid,
      });
    } else {
      debugPrint(
          '----------------------Infos are Not Valid----------------------');
    }
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(color: MyColors.myYellow),
    );
  }
}
