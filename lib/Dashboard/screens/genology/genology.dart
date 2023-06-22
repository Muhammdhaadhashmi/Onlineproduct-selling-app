import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onicame/Dashboard/components/usersidebar.dart';
import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

import '../../../utils/constants.dart';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:graphview/GraphView.dart';

class GenologyScreen extends StatefulWidget {
  static const String id = '/genology';
  const GenologyScreen({Key? key}) : super(key: key);

  @override
  State<GenologyScreen> createState() => _GenologyScreenState();
}

class _GenologyScreenState extends State<GenologyScreen> {
  Future getUserAmount() async {}
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
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
        body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _size.width >= 702 ? const UserSideMenu() : Container(),
          Expanded(
              flex: 6,
              child: show == true
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: InteractiveViewer(
                              constrained: false,
                              boundaryMargin: EdgeInsets.all(100),
                              minScale: 0.01,
                              maxScale: 5.6,
                              child: GraphView(
                                graph: graph,
                                algorithm: BuchheimWalkerAlgorithm(
                                    builder, TreeEdgeRenderer(builder)),
                                paint: Paint()
                                  ..color = Colors.green
                                  ..strokeWidth = 1
                                  ..style = PaintingStyle.stroke,
                                builder: (Node node) {
                                  // I can decide what widget should be shown here based on the id
                                  var a = node.key!.value as int;
                                  return rectangleWidget(a);
                                },
                              )),
                        ),
                      ],
                    )
                  : Container())
        ]));
  }

  Random r = Random();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser(int spon, user) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc('4KhPZEghrxgmVTJVnfnmExj70QA3')
        .update({
          'sponsorcode': spon,
          'usercode': user,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Widget rectangleWidget(int a) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(a.toString()).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Visibility(
            visible: notshow == data['usercode'] ? false : true,
            child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryClr,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  child: Text(
                    "${data['username']}",
                    style: TextStyle(
                        color: kWhiteClr,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )),
          );
        }

        return Text("loading");
      },
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  bool show = false;
  int notshow = 0;
  user2(int uid) {
    FirebaseFirestore.instance
        .collection('users')
        .where('sponsorcode', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          graph.addEdge(
            Node.Id(doc['sponsorcode']),
            Node.Id(doc['usercode']),
          );
          user3(doc['usercode']);
        });
      });
    });
  }

  user3(int uid) {
    FirebaseFirestore.instance
        .collection('users')
        .where('sponsorcode', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          graph.addEdge(
            Node.Id(doc['sponsorcode']),
            Node.Id(doc['usercode']),
          );
          user4(doc['usercode']);
        });
      });
    });
  }

  user4(int uid) {
    FirebaseFirestore.instance
        .collection('users')
        .where('sponsorcode', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          graph.addEdge(
            Node.Id(doc['sponsorcode']),
            Node.Id(doc['usercode']),
          );
          user5(doc['usercode']);
        });
      });
    });
  }

  user5(int uid) {
    FirebaseFirestore.instance
        .collection('users')
        .where('sponsorcode', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          graph.addEdge(
            Node.Id(doc['sponsorcode']),
            Node.Id(doc['usercode']),
          );
          user6(doc['usercode']);
        });
      });
    });
  }

  user6(int uid) {
    FirebaseFirestore.instance
        .collection('users')
        .where('sponsorcode', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          graph.addEdge(
            Node.Id(doc['sponsorcode']),
            Node.Id(doc['usercode']),
          );
          user7(doc['usercode']);
        });
      });
    });
  }

  user7(int uid) {
    FirebaseFirestore.instance
        .collection('users')
        .where('sponsorcode', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          graph.addEdge(
            Node.Id(doc['sponsorcode']),
            Node.Id(doc['usercode']),
          );
          user2(doc['usercode']);
        });
      });
    });
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(box.read('uid'))
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try {
          dynamic usercode = documentSnapshot.get(FieldPath(['usercode']));
          dynamic sponsorcode =
              documentSnapshot.get(FieldPath(['sponsorcode']));
          print(usercode);
          setState(() {
            graph.addEdge(
              Node.Id(sponsorcode),
              Node.Id(usercode),
            );

            show = true;
            user2(usercode);
            notshow = sponsorcode;
          });
        } on StateError catch (e) {
          print('No nested field exists!');
        }
      }
    });

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }
}
