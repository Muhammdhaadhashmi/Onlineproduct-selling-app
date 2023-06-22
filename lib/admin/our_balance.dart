import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';

import 'components/side_menu.dart';

class OurBalance extends StatefulWidget {
  const OurBalance({Key? key}) : super(key: key);

  @override
  _OurBalanceState createState() => _OurBalanceState();
}

class _OurBalanceState extends State<OurBalance> {
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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('adminincome')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Container(
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color: kPrimaryClr.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: FittedBox(
                                child: Column(
                                  children: [
                                    const Text("Our Balance"),
                                    Text("${data['wallet']} PKR"),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    );
                  }).toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
