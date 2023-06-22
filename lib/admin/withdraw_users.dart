import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import 'components/side_menu.dart';

class WithDrawnApply extends StatefulWidget {
  const WithDrawnApply({Key? key}) : super(key: key);

  @override
  _WithDrawnApplyState createState() => _WithDrawnApplyState();
}

class _WithDrawnApplyState extends State<WithDrawnApply> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('applyuserdrawn').snapshots();
  TextEditingController activeid = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference incomeuser =
      FirebaseFirestore.instance.collection('usersIncome');

  Future activeuser(String iddata) async {
    return users
        .doc(iddata)
        .update({'active': true})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future inactiveuser(String id) async {
    return users
        .doc(id)
        .update({'active': false})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  updatepending(String id, String amount) {
    return incomeuser
        .doc(id)
        .update({'panding': false})
        .whenComplete(() => income(id, amount))
        .whenComplete(() => addtoadmin(amount))
        .whenComplete(() => del(id, false))
        .whenComplete(() => uphistory(id, amount))
        .whenComplete(() => EasyLoading.dismiss())
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"))
        .whenComplete(() => EasyLoading.dismiss());
  }

  income(String idd, String amountt) {
    FirebaseFirestore.instance
        .collection('usersIncome')
        .doc(idd)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        int total = documentSnapshot['withdrawn'] + int.parse(amountt);
        int min = documentSnapshot['wallet'] - int.parse(amountt);
        return incomeuser
            .doc(idd)
            .update({
              'wallet': min,
              'withdrawn': total,
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }
    });
    // Call the user's CollectionReference to add a new user
  }

  addtoadmin(String amount) {
    CollectionReference incon =
        FirebaseFirestore.instance.collection('adminincome');
    FirebaseFirestore.instance
        .collection('adminincome')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        int total = doc['wallet'] + int.parse(amount);

        incon
            .doc('1tFg1zFDRrU0lqpiokiWre4Rl053')
            .update({
              'wallet': total,
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }
    });
  }

  del(String id, bool deltrue) {
    if (deltrue == true) {
      return incomeuser
          .doc(id)
          .update({'panding': false})
          .whenComplete(() {
            FirebaseFirestore.instance
                .collection('applyuserdrawn')
                .doc(id)
                .delete()
                .then((value) => print("User Deleted"))
                .catchError((error) => print("Failed to delete user: $error"));
          })
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"))
          .whenComplete(() => EasyLoading.dismiss());
    } else {
      FirebaseFirestore.instance
          .collection('applyuserdrawn')
          .doc(id)
          .delete()
          .then((value) => print("User Deleted"))
          .catchError((error) => print("Failed to delete user: $error"));
    }
  }

  uphistory(String id, String amount) {
    FirebaseFirestore.instance
        .collection('history')
        .doc(id)
        .update({
          'payment': FieldValue.arrayUnion([
            {
              'amount': amount,
              'paymentget': Timestamp.now(),
            }
          ])
        })
        .then((value) => print("User Deleted"))
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
              child: Container(
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
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            color: kPrimaryClr.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  "Name",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: kPrimaryClr,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                20.width,
                                                Text(
                                                  data['name'],
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: kPrimaryClr,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                    onPressed: () {
                                                      del(data['uid'], true);
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ))
                                              ],
                                            ),
                                            10.height,
                                            Row(
                                              children: [
                                                const Text(
                                                  "Payment Method",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                20.width,
                                                Text(
                                                  data['method'],
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            10.height,
                                            Row(
                                              children: [
                                                const Text(
                                                  "Number",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                20.width,
                                                Text(
                                                  data['number'],
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            10.height,
                                            Row(
                                              children: [
                                                const Text(
                                                  "Payment",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                20.width,
                                                Text(
                                                  "${data['amount']}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            10.height,
                                            MaterialButton(
                                              color: kPrimaryClr,
                                              onPressed: () {
                                                EasyLoading.show();
                                                updatepending(data['uid'],
                                                    data['amount']);
                                              },
                                              child: const Text(
                                                "Approve",
                                                style:
                                                    TextStyle(color: kWhiteClr),
                                              ),
                                            )
                                          ],
                                        )),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
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
