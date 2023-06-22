import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';

import 'package:onicame/admin/components/side_menu.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:onicame/utils/widget.dart';
import 'package:nb_utils/nb_utils.dart';

class Privacy extends StatefulWidget {
  static const String id = '/privacy';
  const Privacy({Key? key}) : super(key: key);

  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  CollectionReference users = FirebaseFirestore.instance.collection('privacy');
  TextEditingController headingText = TextEditingController();
  TextEditingController DisText = TextEditingController();

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .doc('mrqkA1v0zC46qXPafJeo')
        .set({
          'heading': headingText.text,
          'description': DisText.text,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  String description = '';
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: DraweAdmin(),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: _size.width >= 702 ? false : true,
        iconTheme: const IconThemeData(color: kWhiteClr),
        title: const Text(
          appName,
          style: TextStyle(color: kWhiteClr),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              addUser();
            },
            child: const Text(
              "Save",
              style: TextStyle(color: kWhiteClr, fontSize: 18),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Get.to(const PrivacyEdit());
            },
            child: const Text(
              "Edit",
              style: TextStyle(color: kWhiteClr, fontSize: 18),
            ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _size.width >= 702 ? const SideMenu() : Container(),
          Expanded(
              flex: 6,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      32.height,
                      const Text(
                        "Privacy Policy",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      32.height,
                      AppTextField(
                        textFieldType: TextFieldType.NAME,
                        keyboardType: TextInputType.name,
                        controller: headingText,
                        autoFocus: true,
                        decoration: inputDecoration(
                            labelText: 'Heading', icon: const Icon(Icons.title)),
                      ),
                      16.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: kPrimaryClr)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: kPrimaryClr,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: const [
                                    Text(
                                      "Preview",
                                      style: TextStyle(color: kWhiteClr),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: MarkdownBody(
                                  softLineBreak: true,
                                  selectable: true,
                                  data: description,
                                  shrinkWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Text(controller.text),
                      MarkdownTextInput(
                        (String value) => setState(() => description = value),
                        description,
                        label: 'Description',
                        maxLines: 10,
                        actions: MarkdownType.values,
                        controller: DisText,
                      ),
                      16.height,
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  InputDecoration fieldDecration({
    required String title,
    required String hint,
    required Widget icon,
    bool isalways = false,
  }) {
    return InputDecoration(
      suffixIcon: icon,
      hintText: hint,
      label: Text(
        title,
        style: const TextStyle(color: kPrimaryClr),
      ),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red), borderRadius: radius()),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red), borderRadius: radius()),
      floatingLabelBehavior:
          isalways ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kSecondarClr), borderRadius: radius()),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryClr), borderRadius: radius()),
    );
  }
}

class PrivacyEdit extends StatefulWidget {
  static const String id = '/privacy-edit';
  const PrivacyEdit({Key? key}) : super(key: key);

  @override
  _PrivacyEditState createState() => _PrivacyEditState();
}

class _PrivacyEditState extends State<PrivacyEdit> {
  CollectionReference users = FirebaseFirestore.instance.collection('privacy');
  TextEditingController headingText = TextEditingController();
  TextEditingController DisText = TextEditingController();
  User? curtUser = FirebaseAuth.instance.currentUser;
  Future<void> updateUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .doc('mrqkA1v0zC46qXPafJeo')
        .update({
          'heading': headingText.text,
          'description': DisText.text,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('privacy')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        headingText.text = doc['heading'];
        DisText.text = doc['description'];
      }
    });
    String description = '';
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: DraweAdmin(),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: _size.width >= 702 ? false : true,
        iconTheme: const IconThemeData(color: kWhiteClr),
        title: const Text(
          appName,
          style: TextStyle(color: kWhiteClr),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              updateUser();
            },
            child: const Text(
              "Save",
              style: TextStyle(color: kWhiteClr, fontSize: 18),
            ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _size.width >= 702 ? const SideMenu() : Container(),
          Expanded(
              flex: 6,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      32.height,
                      const Text(
                        "Privacy Policy",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      32.height,
                      AppTextField(
                        textFieldType: TextFieldType.NAME,
                        keyboardType: TextInputType.name,
                        controller: headingText,
                        autoFocus: true,
                        decoration: inputDecoration(
                            labelText: 'Heading', icon: const Icon(Icons.title)),
                      ),
                      16.height,
                      MarkdownTextInput(
                        (String value) {
                          description = value;
                        },
                        description,
                        label: 'Description',
                        maxLines: 10,
                        actions: MarkdownType.values,
                        controller: DisText,
                      ),
                      16.height,
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  InputDecoration fieldDecration({
    required String title,
    required String hint,
    required Widget icon,
    bool isalways = false,
  }) {
    return InputDecoration(
      suffixIcon: icon,
      hintText: hint,
      label: Text(
        title,
        style: const TextStyle(color: kPrimaryClr),
      ),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red), borderRadius: radius()),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red), borderRadius: radius()),
      floatingLabelBehavior:
          isalways ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kSecondarClr), borderRadius: radius()),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryClr), borderRadius: radius()),
    );
  }
}
