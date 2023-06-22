import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

import '../../../utils/constants.dart';
import '../../components/usersidebar.dart';

class EarningScreen extends StatefulWidget {
  static const String id = '/earning';
  const EarningScreen({Key? key}) : super(key: key);

  @override
  _EarningScreenState createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      "My Earning",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('usersIncome')
                            .where('userid', isEqualTo: box.read("uid"))
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

                          return ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return Column(
                                children: [
                                  EarningLevelCard(
                                    title: 'Level 1',
                                    earning: "${data['level1']}",
                                  ),
                                  EarningLevelCard(
                                    title: 'Level 2',
                                    earning: "${data['level2']}",
                                  ),
                                  EarningLevelCard(
                                    title: 'Level 3',
                                    earning: "${data['level3']}",
                                  ),
                                  EarningLevelCard(
                                    title: 'Level 4',
                                    earning: "${data['level4']}",
                                  ),
                                  EarningLevelCard(
                                    title: 'Level 5',
                                    earning: "${data['level5']}",
                                  ),
                                  EarningLevelCard(
                                    title: 'Level 6',
                                    earning: "${data['level6']}",
                                  ),
                                  EarningLevelCard(
                                    title: 'Level 7',
                                    earning: "${data['level5']}",
                                  ),
                                  EarningLevelCard(
                                    title: 'Level 8',
                                    earning: "${data['level8']}",
                                  ),
                                  EarningLevelCard(
                                    title: 'Level 9',
                                    earning: "${data['level9']}",
                                  ),
                                  40.height,
                                ],
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

class EarningLevelCard extends StatelessWidget {
  final String title, earning;

  const EarningLevelCard({
    Key? key,
    required this.title,
    required this.earning,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: kPrimaryClr.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              "$earning PKR",
              style: const TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
