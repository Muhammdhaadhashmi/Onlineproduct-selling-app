// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onicame/admin/components/viewinactive.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import 'components/side_menu.dart';

class ActiveBuyers extends StatefulWidget {
  const ActiveBuyers({Key? key}) : super(key: key);

  @override
  _ActiveBuyersState createState() => _ActiveBuyersState();
}

class _ActiveBuyersState extends State<ActiveBuyers> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      // .where('active', isEqualTo: false)
      .where('buy', isEqualTo: true)
      .snapshots();
  TextEditingController activeid = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future activeuser(String iddata) async {
    return users
        .doc(iddata)
        .update({'active': true})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future inactiveuser(String iddata) async {
    return users
        .doc(iddata)
        .update({'active': false})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  CollectionReference usersdelete =
      FirebaseFirestore.instance.collection('users');

  Future<void> deleteUser(String id) {
    return usersdelete
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to delete user: $error"));
  }

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
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _size.width >= 702 ? const SideMenu() : Container(),
          Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }

                    return ListView(
                      children: [
                        Column(
                          children: [
                            20.height,
                            Column(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: kPrimaryClr,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewInActive(
                                                        data: document,
                                                      )));
                                        },
                                        title: Text(
                                          data['username'],
                                          style: const TextStyle(
                                              color: kWhiteClr,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        trailing: InkWell(
                                          onTap: () {
                                            showDialog<void>(
                                              context: context,
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Are You Sure?"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Cancel")),
                                                    TextButton(
                                                        onPressed: () {
                                                          deleteUser(
                                                              data['uid']);
                                                        },
                                                        child: const Text(
                                                            "Delete")),
                                                  ],
                                                );
                                              },
                                            );
                                            // Get.dialog(
                                            // AlertDialog(
                                            //   title:
                                            //       const Text("Are You Sure?"),
                                            //   actions: [
                                            //     TextButton(
                                            //         onPressed: () {
                                            //           Get.back();
                                            //         },
                                            //         child:
                                            //             const Text("Cancel")),
                                            //     TextButton(
                                            //         onPressed: () {
                                            //           print("delete");
                                            //           // deleteUser(data['uid']);
                                            //         },
                                            //         child:
                                            //             const Text("Delete")),
                                            //   ],
                                            // )
                                            //
                                            // );
                                            Dialog(
                                              child: AlertDialog(
                                                title:
                                                    const Text("Are You Sure?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child:
                                                          const Text("Cancel")),
                                                  TextButton(
                                                      onPressed: () {
                                                        print("delete");
                                                        // deleteUser(data['uid']);
                                                      },
                                                      child:
                                                          const Text("Delete")),
                                                ],
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        )),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
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
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: radius()),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: radius()),
      floatingLabelBehavior:
          isalways ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kSecondarClr),
          borderRadius: radius()),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryClr),
          borderRadius: radius()),
    );
  }
}

class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback press;
  const MyButton({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: kPrimaryClr,
      minWidth: double.infinity,
      height: 60,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      onPressed: press,
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, color: kWhiteClr),
      ),
    );
  }
}
