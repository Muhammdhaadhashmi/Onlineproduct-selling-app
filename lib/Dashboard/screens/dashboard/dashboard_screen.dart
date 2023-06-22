import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onicame/Dashboard/components/usersidebar.dart';
import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class Dashboard extends StatefulWidget {
  static const String id = '/dashboard';

  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var lastnameTextController = TextEditingController();

  var cnicTextController = TextEditingController();

  var firstnameTextController = TextEditingController();

  var sponsernameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  CollectionReference genealogy =
      FirebaseFirestore.instance.collection('genealogy');
  String pid = '';
  added() {
    FirebaseFirestore.instance
        .collection('genealogy')
        .where('userid', isEqualTo: box.read("uid"))
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        FirebaseFirestore.instance
            .collection('genealogy')
            .doc(doc['userid'])
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            print('Document exists on the database');
            print(documentSnapshot["sponsorname"]);
            FirebaseFirestore.instance
                .collection('genealogy')
                .where('username', isEqualTo: documentSnapshot['sponsorname'])
                .get()
                .then((QuerySnapshot querySnapshot) {
              for (var doc1 in querySnapshot.docs) {
                print(doc1["username"]);
                genealogy
                    .doc(documentSnapshot['sponsorid'])
                    .update({
                      'productname': FieldValue.arrayUnion([
                        {
                          'product': documentSnapshot['username'],
                          'qty': "productQtyController.text",
                        }
                      ]), // John Doe
                    })
                    .then((value) => print("User Added"))
                    .catchError((error) => print("Failed to add user: $error"));
              }
            });
          } else {
            print('No Document exists on the database');
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    Future.delayed(Duration.zero, () {
      if (box.read("login") != true) {
        (context).goNamed("home");
      }
    });
    CollectionReference users =
        FirebaseFirestore.instance.collection('genealogy');
    CollectionReference money =
        FirebaseFirestore.instance.collection('usersIncome');
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(box.read("uid"))
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
              drawer: const Drawer(
                child: UserDraweAdmin(),
              ),
              appBar: AppBar(
                automaticallyImplyLeading: _size.width >= 702 ? false : true,
                iconTheme: const IconThemeData(color: kWhiteClr),
                title: const Text(
                  appName,
                  style: TextStyle(color: kWhiteClr),
                ),
              ),
              body:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _size.width >= 702 ? const UserSideMenu() : Container(),
                Expanded(
                    flex: 6,
                    child: ListView(
                      children: [
                        const Text(
                          "Dashboard",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Wrap(
                            children: [
                              //total members
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .where('sponsorname',
                                        isEqualTo: box.read("firstName"))
                                    .where('active', isEqualTo: false)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text('Something went wrong');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  int totmem = snapshot.data!.size;
                                  return Column(
                                    children: [
                                      FutureBuilder<DocumentSnapshot>(
                                        future: users
                                            .doc(box.read("firstName"))
                                            .get(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<DocumentSnapshot>
                                                snapshot) {
                                          if (snapshot.hasError) {
                                            return const Text(
                                                "Something went wrong");
                                          }

                                          if (snapshot.hasData &&
                                              !snapshot.data!.exists) {
                                            return Container();
                                          }

                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            Map<String, dynamic> data =
                                                snapshot.data!.data()
                                                    as Map<String, dynamic>;

                                            return Column(
                                              children: [
                                                data['productname'] == null
                                                    ? Container()
                                                    : BlockContainer(
                                                        title: "Total Members",
                                                        description:
                                                            "${totmem + data['productname'].length}"),
                                              ],
                                            );
                                          }

                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                              //active members
                              FutureBuilder<DocumentSnapshot>(
                                future: users.doc(box.read("firstName")).get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text("Something went wrong");
                                  }

                                  if (snapshot.hasData &&
                                      !snapshot.data!.exists) {
                                    return Container();
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
                                    return Column(
                                      children: [
                                        data['productname'] == null
                                            ? Container()
                                            : BlockContainer(
                                                title: "Active Members",
                                                description:
                                                    "${data['productname'].length}"),
                                      ],
                                    );
                                  }

                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                              ),

                              //inactive members
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .where('sponsorname',
                                        isEqualTo: box.read("firstName"))
                                    .where('active', isEqualTo: false)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text('Something went wrong');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Text("Loading");
                                  }

                                  return Column(
                                    children: [
                                      BlockContainer(
                                          title: "Inactive Members",
                                          description:
                                              "${snapshot.data!.size}"),
                                    ],
                                  );
                                },
                              ),
                              //Total Earning
                              FutureBuilder<DocumentSnapshot>(
                                future: money.doc(box.read("uid")).get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text("Something went wrong");
                                  }

                                  if (snapshot.hasData &&
                                      !snapshot.data!.exists) {
                                    return const Text(
                                        "Document does not exist");
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;

                                    return Wrap(
                                      children: [
                                        BlockContainer(
                                            title: "Total Earning",
                                            description:
                                                "${data['wallet']} PKR"),
                                        BlockContainer(
                                            title: "Withdrawn Amount",
                                            description:
                                                "${data['withdrawn']} PKR"),
                                      ],
                                    );
                                  }

                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
              ]));
        }

        return const Center(child: CircularProgressIndicator());
      },
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

class BlockContainer extends StatelessWidget {
  const BlockContainer({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Material(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
          width: _size.width >= 506 ? 200 : double.infinity,
          decoration: const BoxDecoration(
            color: kWhiteClr,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
