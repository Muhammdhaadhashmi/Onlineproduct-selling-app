import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onicame/admin/userdetails.dart';
import 'package:onicame/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/widget.dart';
import 'components/side_menu.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final Stream<QuerySnapshot> _usersStreamser = FirebaseFirestore.instance
        .collection('users')
        .where('active', isEqualTo: true)
        .where('username', isEqualTo: searchController.text)
        .snapshots();

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('users')
        .where('active', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots();
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _size.width >= 702 ? const SideMenu() : Container(),
              Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: searchController.text.isEmpty
                          ? _usersStream
                          : _usersStreamser,
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
                          children: [
                            AppTextField(
                              controller: searchController,
                              textFieldType: TextFieldType.NAME,
                              onFieldSubmitted: (value) {
                                setState(() {});
                              },
                              decoration: inputDecoration(
                                  labelText: 'Search',
                                  icon: const Icon(Icons.search)),
                            ),
                            Column(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: kPrimaryClr.withOpacity(0.4),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: ListTile(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return UserDetailsData(
                                                  id: data['uid']);
                                            });
                                      },
                                      title: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text("Name"),
                                              30.width,
                                              Text(data['username']),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      },
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
