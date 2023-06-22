import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:min_id/min_id.dart';
import 'package:onicame/admin/active_buyer.dart';
import 'package:onicame/component/label.dart';
import 'package:onicame/utils/colors.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

class ViewInActive extends StatefulWidget {
  final DocumentSnapshot data;
  const ViewInActive({Key? key, required this.data}) : super(key: key);

  @override
  _ViewInActiveState createState() => _ViewInActiveState();
}

class _ViewInActiveState extends State<ViewInActive> {
  @override
  void initState() {
    per();

    super.initState();
  }

  double payamt = 0.0;
  String pid = '';
  per() {
    setState(() {
      pid = widget.data['uid'];
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
        .doc(widget.data['uid'])
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
        .doc(widget.data['uid'])
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

  ranksandRpadd() {
    EasyLoading.show();
    FirebaseFirestore.instance
        .collection('users')
        .doc(pid)
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
                dynamic nested1 =
                    documentSnapshot1.get(FieldPath(const ['RP']));
                print(nested1);

                FirebaseFirestore.instance
                    .collection('usersIncome')
                    .doc(nested.toString())
                    .update({'RP': nested1 + widget.data['rankpoints']})
                    .then((value) => print("rank Updated"))
                    .whenComplete(() => EasyLoading.dismiss())
                    .catchError(
                        (error) => print("Failed to update user: $error"));

                setState(() {
                  pid = nested.toString();
                  ranksandRpadd2nd();
                });
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

  ranksandRpadd2nd() {
    EasyLoading.show();
    FirebaseFirestore.instance
        .collection('users')
        .doc(pid)
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
                dynamic nested1 =
                    documentSnapshot1.get(FieldPath(const ['RP']));
                print(nested1);

                FirebaseFirestore.instance
                    .collection('usersIncome')
                    .doc(nested.toString())
                    .update({'RP': nested1 + widget.data['rankpoints']})
                    .then((value) => print("rank Updated"))
                    .whenComplete(() => EasyLoading.dismiss())
                    .catchError(
                        (error) => print("Failed to update user: $error"));

                setState(() {
                  pid = nested.toString();
                  ranksandRpadd();
                });
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

  activeuser() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(widget.data['uid'])
        .update({
          'active': true,
          'buy': false,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  activevendorOrder() async {
    final numId = MinId.getId('4{d} 4{d} 4{d} 4{d}');
    final cvvCode = MinId.getId('3{d}');
    print('ID:: $numId');
    return FirebaseFirestore.instance
        .collection('mastercard')
        .doc(widget.data['uid'])
        .set({
          'uid': widget.data['uid'],
          'num': numId,
          'cvvCode': cvvCode,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageLabel(label: widget.data['username']),
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
                      20.height,
                      Styling(title: 'Name', disc: widget.data['username']),
                      20.height,
                      Styling(
                          title: 'Address', disc: "${widget.data['address']}"),
                      20.height,
                      Styling(
                          title: 'Phone', disc: "${widget.data['mobileno']}"),
                      40.height,
                      Image.network(
                        widget.data['invoice'],
                        height: MediaQuery.of(context).size.height * 0.6,
                      ),
                      80.height,
                      MyButton(
                          title: "Active",
                          press: () {
                            EasyLoading.show();
                            addtoadmin();

                            activevendorOrder();
                            user1income();
                            ranksandRpadd();
                            activeuser();
                          }),
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
