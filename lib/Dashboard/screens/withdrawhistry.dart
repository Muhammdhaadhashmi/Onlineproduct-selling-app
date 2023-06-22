import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/usersidebar.dart';

class WithDrawHistry extends StatefulWidget {
  const WithDrawHistry({Key? key}) : super(key: key);

  @override
  State<WithDrawHistry> createState() => _WithDrawHistryState();
}

class _WithDrawHistryState extends State<WithDrawHistry> {
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
              child: Container(
                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('history')
                      .doc(box.read("uid"))
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                          itemCount: data['payment'] == null
                              ? 0
                              : data['payment'].length,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: kPrimaryClr.withOpacity(0.1)),
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
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
                ),
              ))
        ]));
  }
}
