import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onicame/admin/active_buyer.dart';
import 'package:onicame/component/label.dart';
import 'package:onicame/utils/colors.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

class ProductInActive extends StatefulWidget {
  final DocumentSnapshot data;
  final String id;
  const ProductInActive({Key? key, required this.data, required this.id})
      : super(key: key);

  @override
  _ProductInActiveState createState() => _ProductInActiveState();
}

class _ProductInActiveState extends State<ProductInActive> {
  @override
  void initState() {
    per();

    super.initState();
  }

  double payamt = 0.0;
  String pid = '';
  per() {
    setState(() {
      pid = widget.data['vendorid'];
      payamt = widget.data['packageprice'];
    });
  }

  late final double payusamt;
  late final double payusamt1;
  late final double payusamt2;
  late final double payusamt3;
  late final double payusamt4;
  late final double payusamt5;
  late final double payusamt6;
  late final double payusamt7;
  late final double payusamt8;
  late final double payusamt9;
  double percent = 0;
  double percent1 = 7;
  double percent2 = 3;
  double percent3 = 2;
  double percent4 = 1;
  double percent5 = 1;
  double percent6 = 0.5;
  double percent7 = 0.5;
  double percent8 = 0.5;
  double percent9 = 0.5;
  CollectionReference banner =
      FirebaseFirestore.instance.collection('usersIncome');
  CollectionReference addrank =
      FirebaseFirestore.instance.collection('usersIncome');
  int level = 0;
  int closelevel = 1;

  addtoadmin() {
    CollectionReference incon =
        FirebaseFirestore.instance.collection('adminincome');
    FirebaseFirestore.instance
        .collection('adminincome')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        int total = doc['wallet'] + widget.data['packageprice'];

        incon
            .doc("1tFg1zFDRrU0lqpiokiWre4Rl053")
            .update({
              'wallet': total,
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }
    });
  }

  user1income() {
    EasyLoading.show();
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.data['customerid'])
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try {
          dynamic nested =
              documentSnapshot.get(FieldPath(const ['sponsorcode']));

          FirebaseFirestore.instance
              .collection('usersIncome')
              .doc(nested.toString())
              .get()
              .then((DocumentSnapshot documentSnapshot1) {
            if (documentSnapshot1.exists) {
              print(documentSnapshot1.data());

              try {
                dynamic level1 =
                    documentSnapshot1.get(FieldPath(const ['level1']));
                dynamic wallet =
                    documentSnapshot1.get(FieldPath(const ['wallet']));
                print(level1);
                ///////

                ///
                double totalpay = (payamt / 100) * percent1;

                int totwallet = wallet + totalpay;
                print(level1 + totalpay);
                print(totwallet);
                FirebaseFirestore.instance
                    .collection('usersIncome')
                    .doc(nested.toString())
                    .update({
                      'level1': level1 + totalpay,
                      "wallet": totwallet,
                    })
                    .then((value) => print("income Updated"))
                    .whenComplete(() => EasyLoading.dismiss())
                    .catchError(
                        (error) => print("Failed to update income: $error"));

                // setState(() {
                user2income(nested.toString());
                // });
              } on StateError {
                print('No nested field exists!');
              }
            }
          });
        } on StateError {
          print('No nested field exists!');
        }
      }
    });
  }

  user2income(String uid) {
    EasyLoading.show();
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try {
          dynamic nested =
              documentSnapshot.get(FieldPath(const ['sponsorcode']));

          FirebaseFirestore.instance
              .collection('usersIncome')
              .doc(nested.toString())
              .get()
              .then((DocumentSnapshot documentSnapshot1) {
            if (documentSnapshot1.exists) {
              print(documentSnapshot1.data());

              try {
                dynamic level1 =
                    documentSnapshot1.get(FieldPath(const ['level2']));
                dynamic wallet =
                    documentSnapshot1.get(FieldPath(const ['wallet']));
                print(level1);
                ///////

                ///
                double totalpay = (payamt / 100) * percent2;

                int totwallet = wallet + totalpay;
                print(level1 + totalpay);
                print(totwallet);
                FirebaseFirestore.instance
                    .collection('usersIncome')
                    .doc(nested.toString())
                    .update({
                      'level2': level1 + totalpay,
                      "wallet": totwallet,
                    })
                    .then((value) => print("income Updated"))
                    .whenComplete(() => EasyLoading.dismiss())
                    .catchError(
                        (error) => print("Failed to update income: $error"));

                // setState(() {
                user3income(nested.toString());
                // });
              } on StateError {
                print('No nested field exists!');
              }
            }
          });
        } on StateError {
          print('No nested field exists!');
        }
      }
    });
  }

  user3income(String uid) {
    EasyLoading.show();
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try {
          dynamic nested =
              documentSnapshot.get(FieldPath(const ['sponsorcode']));

          FirebaseFirestore.instance
              .collection('usersIncome')
              .doc(nested.toString())
              .get()
              .then((DocumentSnapshot documentSnapshot1) {
            if (documentSnapshot1.exists) {
              print(documentSnapshot1.data());

              try {
                dynamic level1 =
                    documentSnapshot1.get(FieldPath(const ['level3']));
                dynamic wallet =
                    documentSnapshot1.get(FieldPath(const ['wallet']));
                print(level1);
                ///////

                ///
                double totalpay = (payamt / 100) * percent3;

                int totwallet = wallet + totalpay;
                print(level1 + totalpay);
                print(totwallet);
                FirebaseFirestore.instance
                    .collection('usersIncome')
                    .doc(nested.toString())
                    .update({
                      'level3': level1 + totalpay,
                      "wallet": totwallet,
                    })
                    .then((value) => print("income Updated"))
                    .catchError(
                        (error) => print("Failed to update income: $error"))
                    .whenComplete(() => EasyLoading.dismiss());

                // setState(() {
                user4income(nested.toString());
                // });
              } on StateError {
                print('No nested field exists!');
              }
            }
          });
        } on StateError {
          print('No nested field exists!');
        }
      }
    });
  }

  user4income(String uid) {
    EasyLoading.show();
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try {
          dynamic nested =
              documentSnapshot.get(FieldPath(const ['sponsorcode']));

          FirebaseFirestore.instance
              .collection('usersIncome')
              .doc(nested.toString())
              .get()
              .then((DocumentSnapshot documentSnapshot1) {
            if (documentSnapshot1.exists) {
              print(documentSnapshot1.data());

              try {
                dynamic level1 =
                    documentSnapshot1.get(FieldPath(const ['level4']));
                dynamic wallet =
                    documentSnapshot1.get(FieldPath(const ['wallet']));
                print(level1);
                ///////

                ///
                double totalpay = (payamt / 100) * percent4;

                int totwallet = wallet + totalpay;
                print(level1 + totalpay);
                print(totwallet);
                FirebaseFirestore.instance
                    .collection('usersIncome')
                    .doc(nested.toString())
                    .update({
                      'level4': level1 + totalpay,
                      "wallet": totwallet,
                    })
                    .then((value) => print("income Updated"))
                    .whenComplete(() => EasyLoading.dismiss())
                    .catchError(
                        (error) => print("Failed to update income: $error"));

                // setState(() {
                user5income(nested.toString());
                // });
              } on StateError {
                print('No nested field exists!');
              }
            }
          });
        } on StateError {
          print('No nested field exists!');
        }
      }
    });
  }

  user5income(String uid) {
    EasyLoading.show();
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try {
          dynamic nested =
              documentSnapshot.get(FieldPath(const ['sponsorcode']));

          FirebaseFirestore.instance
              .collection('usersIncome')
              .doc(nested.toString())
              .get()
              .then((DocumentSnapshot documentSnapshot1) {
            if (documentSnapshot1.exists) {
              print(documentSnapshot1.data());

              try {
                dynamic level1 =
                    documentSnapshot1.get(FieldPath(const ['level5']));
                dynamic wallet =
                    documentSnapshot1.get(FieldPath(const ['wallet']));
                print(level1);
                ///////

                ///
                double totalpay = (payamt / 100) * percent5;

                int totwallet = wallet + totalpay;
                print(level1 + totalpay);
                print(totwallet);
                FirebaseFirestore.instance
                    .collection('usersIncome')
                    .doc(nested.toString())
                    .update({
                      'level5': level1 + totalpay,
                      "wallet": totwallet,
                    })
                    .then((value) => print("income Updated"))
                    .whenComplete(() => EasyLoading.dismiss())
                    .catchError(
                        (error) => print("Failed to update income: $error"));

                // setState(() {
                user6income(nested.toString());
                // });
              } on StateError {
                print('No nested field exists!');
              }
            }
          });
        } on StateError {
          print('No nested field exists!');
        }
      }
    });
  }

  user6income(String uid) {
    EasyLoading.show();
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try {
          dynamic nested =
              documentSnapshot.get(FieldPath(const ['sponsorcode']));

          FirebaseFirestore.instance
              .collection('usersIncome')
              .doc(nested.toString())
              .get()
              .then((DocumentSnapshot documentSnapshot1) {
            if (documentSnapshot1.exists) {
              print(documentSnapshot1.data());

              try {
                dynamic level1 =
                    documentSnapshot1.get(FieldPath(const ['level6']));
                dynamic wallet =
                    documentSnapshot1.get(FieldPath(const ['wallet']));
                print(level1);
                ///////

                ///
                double totalpay = (payamt / 100) * percent6;

                int totwallet = wallet + totalpay;
                print(level1 + totalpay);
                print(totwallet);
                FirebaseFirestore.instance
                    .collection('usersIncome')
                    .doc(nested.toString())
                    .update({
                      'level6': level1 + totalpay,
                      "wallet": totwallet,
                    })
                    .then((value) => print("income Updated"))
                    .whenComplete(() => EasyLoading.dismiss())
                    .catchError(
                        (error) => print("Failed to update income: $error"));

                // setState(() {
                user7income(nested.toString());
                // });
              } on StateError {
                print('No nested field exists!');
              }
            }
          });
        } on StateError {
          print('No nested field exists!');
        }
      }
    });
  }

  user7income(String uid) {
    EasyLoading.show();
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.data['vendorid'])
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try {
          dynamic nested =
              documentSnapshot.get(FieldPath(const ['sponsorcode']));

          FirebaseFirestore.instance
              .collection('usersIncome')
              .doc(uid)
              .get()
              .then((DocumentSnapshot documentSnapshot1) {
            if (documentSnapshot1.exists) {
              print(documentSnapshot1.data());

              try {
                dynamic level1 =
                    documentSnapshot1.get(FieldPath(const ['level7']));
                dynamic wallet =
                    documentSnapshot1.get(FieldPath(const ['wallet']));
                print(level1);
                ///////

                ///
                double totalpay = (payamt / 100) * percent7;

                int totwallet = wallet + totalpay;
                print(level1 + totalpay);
                print(totwallet);
                FirebaseFirestore.instance
                    .collection('usersIncome')
                    .doc(nested.toString())
                    .update({
                      'level7': level1 + totalpay,
                      "wallet": totwallet,
                    })
                    .then((value) => print("income Updated"))
                    .whenComplete(() => EasyLoading.dismiss())
                    .catchError(
                        (error) => print("Failed to update income: $error"));

                // setState(() {
                user8income(nested.toString());
                // });
              } on StateError {
                print('No nested field exists!');
              }
            }
          });
        } on StateError {
          print('No nested field exists!');
        }
      }
    });
  }

  user8income(String uid) {
    EasyLoading.show();
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try {
          dynamic nested =
              documentSnapshot.get(FieldPath(const ['sponsorcode']));

          FirebaseFirestore.instance
              .collection('usersIncome')
              .doc(nested.toString())
              .get()
              .then((DocumentSnapshot documentSnapshot1) {
            if (documentSnapshot1.exists) {
              print(documentSnapshot1.data());

              try {
                dynamic level1 =
                    documentSnapshot1.get(FieldPath(const ['level8']));
                dynamic wallet =
                    documentSnapshot1.get(FieldPath(const ['wallet']));
                print(level1);
                ///////

                ///
                double totalpay = (payamt / 100) * percent8;

                int totwallet = wallet + totalpay;
                print(level1 + totalpay);
                print(totwallet);
                FirebaseFirestore.instance
                    .collection('usersIncome')
                    .doc(nested.toString())
                    .update({
                      'level8': level1 + totalpay,
                      "wallet": totwallet,
                    })
                    .then((value) => print("income Updated"))
                    .whenComplete(() => EasyLoading.dismiss())
                    .catchError(
                        (error) => print("Failed to update income: $error"));

                // setState(() {
                user9income(nested.toString());
                // });
              } on StateError {
                print('No nested field exists!');
              }
            }
          });
        } on StateError {
          print('No nested field exists!');
        }
      }
    });
  }

  user9income(String uid) {
    EasyLoading.show();
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try {
          dynamic nested =
              documentSnapshot.get(FieldPath(const ['sponsorcode']));

          FirebaseFirestore.instance
              .collection('usersIncome')
              .doc(nested.toString())
              .get()
              .then((DocumentSnapshot documentSnapshot1) {
            if (documentSnapshot1.exists) {
              print(documentSnapshot1.data());

              try {
                dynamic level1 =
                    documentSnapshot1.get(FieldPath(const ['level9']));
                dynamic wallet =
                    documentSnapshot1.get(FieldPath(const ['wallet']));
                print(level1);
                ///////

                ///
                double totalpay = (payamt / 100) * percent9;

                int totwallet = wallet + totalpay;
                print(level1 + totalpay);
                print(totwallet);
                FirebaseFirestore.instance
                    .collection('usersIncome')
                    .doc(nested.toString())
                    .update({
                      'level9': level1 + totalpay,
                      "wallet": totwallet,
                    })
                    .then((value) => print("income Updated"))
                    .whenComplete(() => EasyLoading.dismiss())
                    .catchError(
                        (error) => print("Failed to update income: $error"));

                // setState(() {
                //   ranksandRpadd2nd();
                // });
              } on StateError {
                print('No nested field exists!');
              }
            }
          });
        } on StateError {
          print('No nested field exists!');
        }
      }
    });
  }

  // ranksandRpadd() {
  //   EasyLoading.show();
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(pid)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       try {
  //         dynamic nested = documentSnapshot.get(FieldPath(['sponsorcode']));

  //         FirebaseFirestore.instance
  //             .collection('usersIncome')
  //             .doc(nested.toString())
  //             .get()
  //             .then((DocumentSnapshot documentSnapshot1) {
  //           if (documentSnapshot1.exists) {
  //             print(documentSnapshot1.data());

  //             try {
  //               dynamic nested1 = documentSnapshot1.get(FieldPath(['RP']));
  //               print(nested1);

  //               FirebaseFirestore.instance
  //                   .collection('usersIncome')
  //                   .doc(nested.toString())
  //                   .update({'RP': nested1 + widget.data['rankpoints']})
  //                   .then((value) => print("rank Updated"))
  //                   .whenComplete(() => EasyLoading.dismiss())
  //                   .catchError(
  //                       (error) => print("Failed to update user: $error"));

  //               setState(() {
  //                 pid = nested.toString();
  //                 ranksandRpadd2nd();
  //               });
  //             } on StateError catch (e) {
  //               print('No nested field exists!');
  //             }
  //           }
  //         });
  //       } on StateError catch (e) {
  //         print('No nested field exists!');
  //       }
  //     }
  //   });
  // }

  // ranksandRpadd2nd() {
  //   EasyLoading.show();
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(pid)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       try {
  //         dynamic nested = documentSnapshot.get(FieldPath(['sponsorcode']));

  //         FirebaseFirestore.instance
  //             .collection('usersIncome')
  //             .doc(nested.toString())
  //             .get()
  //             .then((DocumentSnapshot documentSnapshot1) {
  //           if (documentSnapshot1.exists) {
  //             print(documentSnapshot1.data());

  //             try {
  //               dynamic nested1 = documentSnapshot1.get(FieldPath(['RP']));
  //               print(nested1);

  //               FirebaseFirestore.instance
  //                   .collection('usersIncome')
  //                   .doc(nested.toString())
  //                   .update({'RP': nested1 + widget.data['rankpoints']})
  //                   .then((value) => print("rank Updated"))
  //                   .whenComplete(() => EasyLoading.dismiss())
  //                   .catchError(
  //                       (error) => print("Failed to update user: $error"));

  //               setState(() {
  //                 pid = nested.toString();
  //                 ranksandRpadd();
  //               });
  //             } on StateError catch (e) {
  //               print('No nested field exists!');
  //             }
  //           }
  //         });
  //       } on StateError catch (e) {
  //         print('No nested field exists!');
  //       }
  //     }
  //   });
  // }

  activeuser() {
    return FirebaseFirestore.instance
        .collection('buyproducts')
        .doc(widget.id)
        .update({
          'active': true,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  activevendorOrder() async {
    return FirebaseFirestore.instance
        .collection('vendororders')
        .add({
          'customerid': widget.data['customerid'],
          'vendorid': widget.data['vendorid'],
          'productname': widget.data['packagename'],
          'packageprice': widget.data['packageprice'],
          'packagedelivery': widget.data['deliveryprice'],
          'image': widget.data['productimage'],
          'deliverd': false,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageLabel(label: widget.data['packagename']),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: kMaxWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      // Styling(title: 'Name', disc: widget.data['username']),
                      20.height,

                      Styling(
                          title: 'Package Name',
                          disc: widget.data['packagename']),
                      20.height,
                      Styling(
                          title: 'Package Price',
                          disc:
                              "${widget.data['packageprice'] - widget.data['deliveryprice']}"),
                      20.height,
                      Styling(
                          title: 'Delivery Charges',
                          disc: "${widget.data['deliveryprice']}"),
                      20.height, Styling(title: 'Product Detail', disc: ""),

                      Text(
                        widget.data['prodcutdiscription'],
                        style: TextStyle(fontSize: 16, height: 1.3),
                      ),
                      20.height,
                      FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.data['vendorid'])
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Something went wrong");
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return const Text("Document does not exist");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Column(
                              children: [
                                Styling(
                                    title: 'Vendor Name',
                                    disc:
                                        "${data['firstName']} ${data['lastname']}"),
                                20.height,
                                Styling(
                                    title: 'Vendor Address',
                                    disc: "${data['address']}"),
                                20.height,
                                Styling(
                                    title: 'Vendor Phone',
                                    disc: "${data['mobileno']}"),
                                20.height,
                              ],
                            );
                          }

                          return const Text("loading");
                        },
                      ),
                      FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.data['customerid'])
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Something went wrong");
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return const Text("Document does not exist");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Column(
                              children: [
                                Styling(
                                    title: 'Cutomer Name',
                                    disc:
                                        "${data['firstName']} ${data['lastname']}"),
                                20.height,
                                Styling(
                                    title: 'Cutomer Address',
                                    disc: "${data['address']}"),
                                20.height,
                                Styling(
                                    title: 'Cutomer Phone',
                                    disc: "${data['mobileno']}"),
                                20.height,
                              ],
                            );
                          }

                          return const Text("loading");
                        },
                      ),

                      10.height,
                      const Text(
                        "Invoice",
                        style: TextStyle(fontSize: 16),
                      ),
                      10.height,
                      Image.network(
                        widget.data['invoice'],
                        height: MediaQuery.of(context).size.height * 0.6,
                      ),

                      10.height,
                      Divider(),
                      Text(
                        "Product Image",
                        style: TextStyle(fontSize: 16),
                      ),
                      10.height,
                      Image.network(
                        widget.data['productimage'],
                        height: MediaQuery.of(context).size.height * 0.6,
                      ),
                      80.height,
                      MyButton(
                          title: "Active",
                          press: () {
                            EasyLoading.show();
                            addtoadmin();
                            user1income();
                            activevendorOrder();
                            activeuser();
                            // ranksandRpadd();
                          }),
                      20.height,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Styling extends StatelessWidget {
  final String title, disc;
  const Styling({
    Key? key,
    required this.title,
    required this.disc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        30.width,
        Text(
          disc,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}
