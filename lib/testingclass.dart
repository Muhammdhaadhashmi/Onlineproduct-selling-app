import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class TestingClass extends StatefulWidget {
  const TestingClass({Key? key}) : super(key: key);

  @override
  State<TestingClass> createState() => _TestingClassState();
}

class _TestingClassState extends State<TestingClass> {
  int c = 25;
  TextEditingController _control = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        body: show == true
            ? Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    controller: _control,
                  ),
                  Wrap(
                    children: [
                      Container(
                        width: 100,
                        child: TextFormField(
                          initialValue: builder.siblingSeparation.toString(),
                          decoration:
                              InputDecoration(labelText: "Sibling Separation"),
                          onChanged: (text) {
                            builder.siblingSeparation =
                                int.tryParse(text) ?? 100;
                            this.setState(() {});
                          },
                        ),
                      ),
                      Container(
                        width: 100,
                        child: TextFormField(
                          initialValue: builder.levelSeparation.toString(),
                          decoration:
                              InputDecoration(labelText: "Level Separation"),
                          onChanged: (text) {
                            builder.levelSeparation = int.tryParse(text) ?? 100;
                            this.setState(() {});
                          },
                        ),
                      ),
                      Container(
                        width: 100,
                        child: TextFormField(
                          initialValue: builder.subtreeSeparation.toString(),
                          decoration:
                              InputDecoration(labelText: "Subtree separation"),
                          onChanged: (text) {
                            builder.subtreeSeparation =
                                int.tryParse(text) ?? 100;
                            this.setState(() {});
                          },
                        ),
                      ),
                      Container(
                        width: 100,
                        child: TextFormField(
                          initialValue: builder.orientation.toString(),
                          decoration: InputDecoration(labelText: "Orientation"),
                          onChanged: (text) {
                            builder.orientation = int.tryParse(text) ?? 100;
                            this.setState(() {});
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final node12 = Node.Id(r.nextInt(100));
                          var edge = graph
                              .getNodeAtPosition(r.nextInt(graph.nodeCount()));
                          print(edge);
                          graph.addEdge(edge, node12);
                          setState(() {});
                        },
                        child: Text("Add"),
                      )
                    ],
                  ),
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
            : Container());
  }

  Random r = Random();
  CollectionReference users = FirebaseFirestore.instance.collection('testing');
  Future<void> addUser(int spon, user) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(user.toString())
        .set({'sponsorcode': spon, 'usercode': user, 'name': "umair"})
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
          return Text("Full Name: ${data['name']}");
        }

        return Text("loading");
      },
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  bool show = false;
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('testing')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          graph.addEdge(
            Node.Id(doc['sponsorcode']),
            Node.Id(doc['usercode']),
          );
          show = true;
        });
      });
    });
    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }
}
