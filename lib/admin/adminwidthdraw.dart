import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onicame/admin/components/side_menu.dart';
import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/widget.dart';

class AdminWithDrawHistry extends StatefulWidget {
  const AdminWithDrawHistry({Key? key}) : super(key: key);

  @override
  State<AdminWithDrawHistry> createState() => _AdminWithDrawHistryState();
}

class _AdminWithDrawHistryState extends State<AdminWithDrawHistry> {
  TextEditingController searchController = TextEditingController();

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('history').snapshots();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    final Stream<QuerySnapshot> _usersStreamser = FirebaseFirestore.instance
        .collection('history')
        .where('name', isEqualTo: searchController.text)
        .snapshots();
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
        body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _size.width >= 702 ? const SideMenu() : Container(),
          Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppTextField(
                        controller: searchController,
                        textFieldType: TextFieldType.NAME,
                        onFieldSubmitted: (value) {},
                        onChanged: (val) {
                          setState(() {});
                        },
                        decoration: inputDecoration(
                            labelText: 'Search',
                            icon: const Icon(Icons.search)),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: searchController.text.isEmpty
                            ? _usersStream
                            : _usersStreamser,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          return ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                                child: ShowWithdarwDetail(
                                              uid: data['uid'],
                                            )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: kPrimaryClr,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListTile(
                                      title: Text(data['name']),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ))
        ]));
  }
}

class ShowWithdarwDetail extends StatelessWidget {
  final String uid;
  const ShowWithdarwDetail({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('history').doc(uid).get(),
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
          return ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: data['payment'] == null ? 0 : data['payment'].length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration:
                          BoxDecoration(color: kPrimaryClr.withOpacity(0.1)),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: kWhiteClr,
                                    child: Text("${index + 1}"),
                                  ),
                                  5.width,
                                  Row(
                                    children: [
                                      const Text(
                                        "Amount",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      10.width,
                                      Text(
                                          "${data['payment'][index]['amount']}"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Date",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                10.width,
                                Text(
                                    "${(data['payment'][index]['paymentget']).toDate()}"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
        }

        return const Text("loading");
      },
    );
  }
}
