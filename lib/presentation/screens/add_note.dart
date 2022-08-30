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

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  //to upload files
  File? file;
  //Form fields
  late String noteTitle, noteBody, imageUrl;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late Reference ref;
  //
  CollectionReference noteRefs = FirebaseFirestore.instance.collection("notes");

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: bgColor,
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
              "ADD",
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
                        color: white,
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
                      style:
                          TextStyle(fontSize: 15, color: white.withOpacity(.8)),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: 'Note Title',
                        hintStyle: TextStyle(color: white.withOpacity(.6)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: white.withOpacity(0.4))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: white.withOpacity(0.4))),
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
                        color: white,
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
                      style:
                          TextStyle(fontSize: 17, color: white.withOpacity(.8)),
                      decoration: InputDecoration(
                        hintText: 'Write Your Note',
                        hintStyle: TextStyle(color: white.withOpacity(.6)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: white.withOpacity(0.4))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: white.withOpacity(0.4))),
                      ),
                    ),
                  ),
                  //Upload Button
                  // Container(
                  //   margin: EdgeInsets.only(top: 12, bottom: 16),
                  //   decoration: BoxDecoration(
                  //     color: MyColors.myYellow,
                  //     shape: BoxShape.rectangle,
                  //     borderRadius: BorderRadius.all(Radius.circular(8)),
                  //   ),
                  //   width: SizeConfig.screenWidth * .9,
                  //   child: TextButton(
                  //       child: Text('UPLOAD IMAGE',
                  //           style:
                  //               TextStyle(fontSize: 22, color: Colors.white)),
                  //       onPressed: null
                  //       // () async {
                  //       //   //
                  //       //   //showBottomSheet(context);
                  //       // },
                  //       ),
                  // ),
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
                        child: Text('ADD NOTE',
                            style: TextStyle(fontSize: 17, color: white)),
                        onPressed: () async {
                          //
                          await addNote();
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

  addNote() async {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      debugPrint(
          '---------------------- Fields are Valid----------------------');
      //trigger on save fucn in each button to save the values
      formData.save();
      // //save image to storage
      // await ref.putFile(file!);
      // imageUrl = await ref.getDownloadURL();
      //showLoadingIndicator();
      //add the note to firestorage
      await noteRefs.add({
        "title": noteTitle,
        "note": noteBody,
        "image_url": null, //imageUrl,
        "user_id": FirebaseAuth.instance.currentUser!.uid,
      });
    } else {
      debugPrint(
          '----------------------Infos are Not Valid----------------------');
      //return null;
    }
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(color: MyColors.myYellow),
    );
  }

  showBottomSheet(context) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: SizeConfig.screenHeight * .25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please Choose Image',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              InkWell(
                onTap: () async {
                  XFile? picked = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    file = File(picked.path);
                    int random = Random().nextInt(100000);
                    //this prints the image name.png with random number
                    String imageName = "$random${basename(picked.path)}";
                    //upload
                    ref =
                        FirebaseStorage.instance.ref("images").child(imageName);
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.photo_album_outlined, size: 30),
                      SizedBox(width: 12.0),
                      Text(
                        'From Gallery',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  var picked =
                      await ImagePicker().pickImage(source: ImageSource.camera);

                  if (picked != null) {
                    file = File(picked.path);
                    var random = Random().nextInt(100000);
                    var imageName = "$random${basename(picked.path)}";

                    ref =
                        FirebaseStorage.instance.ref("images").child(imageName);

                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.camera, size: 30),
                      SizedBox(width: 12.0),
                      Text(
                        'From Camera',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
