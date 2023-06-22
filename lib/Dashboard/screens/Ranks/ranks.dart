import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onicame/admin/active_buyer.dart';
import 'package:onicame/main.dart';
import 'package:onicame/model/tabelmodel.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

import '../../components/usersidebar.dart';

class RankScreen extends StatefulWidget {
  static const String id = '/ranks';
  const RankScreen({Key? key}) : super(key: key);

  @override
  _RankScreenState createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  final double _currentSliderValue = 20;
  CollectionReference users = FirebaseFirestore.instance.collection('RanksPay');
  Future<void> addUser() async {
    // Call the user's CollectionReference to add a new user
    users
        .doc(box.read("uid"))
        .update({
          'name': box.read("firstName"),
          'uid': box.read("uid"),
          "Distributor": true,
          'Silver': false,
          'Gold': false,
          'Platinum': false,
          'Diamond': false,
          'Crown': false,
          'Double Crown': false,
          'Star': false,
          'Double Star': false,
          'Super Star': false,
          'Royal': false,
          'Royal Achiever': false,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // panding() {
  //   CollectionReference users =
  //       FirebaseFirestore.instance.collection('Rankslevel');
  //   return users
  //       .add({
  //         "Distributor": {"rankpoints": "2500", "award": "7000"},
  //         "Silver": {'rankpoints': "10000", 'award': "200000"},
  //         "Gold": {'rankpoints': "25000", 'award': "40000"},
  //         "Platinum": {'rankpoints': "50000", 'award': "70000"},
  //         "Diamond": {'rankpoints': "100000", 'award': "Trip + 70000"},
  //         "Crown": {'rankpoints': "250000", 'award': "250000"},
  //         "Double Crown": {'rankpoints': "500000", 'award': "500000"},
  //         "Star": {'rankpoints': "1000000", 'award': "10,00,000"},
  //         "Double Star": {'rankpoints': "2500000", 'award': "25,00,000"},
  //         "Super Star": {'rankpoints': "5000000", 'award': "50,00,000"},
  //         "Royal": {'rankpoints': "10000000", 'award': "1,00,00,000"},
  //         "Royal Achiever": {'rankpoints': "40000000", 'award': "4,00,00,000"},
  //       })
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

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
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ListView(children: [
                    const Center(
                      child: Text(
                        "Ranks",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    10.height,
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                        color: kWhiteClr,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: _size.width >= 570 ? 150 : 90,
                                child: Text(
                                  'Rank Name',
                                  style: TextStyle(
                                    fontSize: _size.width >= 570 ? 20 : 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: _size.width >= 570 ? 110 : 90,
                                child: Text(
                                  'Rank Points',
                                  style: TextStyle(
                                    fontSize: _size.width >= 570 ? 20 : 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: _size.width >= 570 ? 110 : 90,
                                child: Text(
                                  'Rank Award',
                                  style: TextStyle(
                                    fontSize: _size.width >= 570 ? 20 : 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: rnkpoint.length,
                              itemBuilder: (context, index) => Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width:
                                                _size.width >= 570 ? 150 : 90,
                                            child: Text(rnkpoint[index].title,
                                                style: TextStyle(
                                                    fontSize: _size.width >= 570
                                                        ? 18
                                                        : 14.0)),
                                          ),
                                          SizedBox(
                                            width:
                                                _size.width >= 570 ? 110 : 90,
                                            child: Text(
                                                rnkpoint[index].rankpoints,
                                                style: TextStyle(
                                                    fontSize: _size.width >= 570
                                                        ? 18
                                                        : 14.0)),
                                          ),
                                          SizedBox(
                                            width:
                                                _size.width >= 570 ? 110 : 100,
                                            child: Text(rnkpoint[index].award,
                                                style: TextStyle(
                                                    fontSize: _size.width >= 570
                                                        ? 18
                                                        : 14.0)),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                    ],
                                  ))
                        ],
                      ),
                    ),
                    20.height,
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Rankslevel')
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
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data1 =
                                document.data()! as Map<String, dynamic>;
                            return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('usersIncome')
                                  .doc(box.read("uid"))
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return const Text("Something went wrong");
                                }

                                if (snapshot.hasData &&
                                    !snapshot.data!.exists) {
                                  return const Text("Document does not exist");
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  Map<String, dynamic> data = snapshot.data!
                                      .data() as Map<String, dynamic>;
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width:
                                                _size.width >= 570 ? 150 : 90,
                                            child: Text(
                                              'My Rank',
                                              style: TextStyle(
                                                fontSize: _size.width >= 570
                                                    ? 20
                                                    : 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                _size.width >= 570 ? 110 : 90,
                                            child: Text(
                                              'My RP',
                                              style: TextStyle(
                                                fontSize: _size.width >= 570
                                                    ? 20
                                                    : 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                _size.width >= 570 ? 110 : 90,
                                            child: Text(
                                              'My Award',
                                              style: TextStyle(
                                                fontSize: _size.width >= 570
                                                    ? 20
                                                    : 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  kPrimaryClr.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: MYrpLevelCard(
                                            level: 'Distributor',
                                            rp: '${data['RP']}',
                                            award: data['RP'] >=
                                                    int.parse(
                                                        data1['Distributor']
                                                            ['rankpoints'])
                                                ? '${data1['Distributor']['award']}'
                                                : '${0}',
                                            icon: data['RP'] >=
                                                    int.parse(
                                                        data1['Distributor']
                                                            ['rankpoints'])
                                                ? Icons.done
                                                : Icons.account_tree_rounded,
                                          ),
                                        ),
                                      ),
                                      //silver
                                      Visibility(
                                        visible: data['RP'] >=
                                                int.parse(data1['Distributor']
                                                    ['rankpoints'])
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kPrimaryClr
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: MYrpLevelCard(
                                              level: 'Silver',
                                              rp: '${data['RP']}',
                                              award: data['RP'] >=
                                                      int.parse(data1['Silver']
                                                          ['rankpoints'])
                                                  ? '${data1['Silver']['award']}'
                                                  : '${0}',
                                              icon: data['RP'] >=
                                                      int.parse(data1['Silver']
                                                          ['rankpoints'])
                                                  ? Icons.done
                                                  : Icons.account_tree_rounded,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Gold
                                      Visibility(
                                        visible: data['RP'] >=
                                                int.parse(data1['Silver']
                                                    ['rankpoints'])
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kPrimaryClr
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: MYrpLevelCard(
                                              level: 'Gold',
                                              rp: '${data['RP']}',
                                              award: data['RP'] >=
                                                      int.parse(data1['Gold']
                                                          ['rankpoints'])
                                                  ? '${data1['Gold']['award']}'
                                                  : '${0}',
                                              icon: data['RP'] >=
                                                      int.parse(data1['Gold']
                                                          ['rankpoints'])
                                                  ? Icons.done
                                                  : Icons.account_tree_rounded,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Platinum
                                      Visibility(
                                        visible: data['RP'] >=
                                                int.parse(
                                                    data1['Gold']['rankpoints'])
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kPrimaryClr
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: MYrpLevelCard(
                                              level: 'Platinum',
                                              rp: '${data['RP']}',
                                              award: data['RP'] >=
                                                      int.parse(
                                                          data1['Platinum']
                                                              ['rankpoints'])
                                                  ? '${data1['Platinum']['award']}'
                                                  : '${0}',
                                              icon: data['RP'] >=
                                                      int.parse(
                                                          data1['Platinum']
                                                              ['rankpoints'])
                                                  ? Icons.done
                                                  : Icons.account_tree_rounded,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Diamond
                                      Visibility(
                                        visible: data['RP'] >=
                                                int.parse(data1['Platinum']
                                                    ['rankpoints'])
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kPrimaryClr
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: MYrpLevelCard(
                                              level: 'Diamond',
                                              rp: '${data['RP']}',
                                              award: data['RP'] >=
                                                      int.parse(data1['Diamond']
                                                          ['rankpoints'])
                                                  ? '${data1['Diamond']['award']}'
                                                  : '${0}',
                                              icon: data['RP'] >=
                                                      int.parse(data1['Diamond']
                                                          ['rankpoints'])
                                                  ? Icons.done
                                                  : Icons.account_tree_rounded,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Crown
                                      Visibility(
                                        visible: data['RP'] >=
                                                int.parse(data1['Diamond']
                                                    ['rankpoints'])
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kPrimaryClr
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: MYrpLevelCard(
                                              level: 'Crown',
                                              rp: '${data['RP']}',
                                              award: data['RP'] >=
                                                      int.parse(data1['Crown']
                                                          ['rankpoints'])
                                                  ? '${data1['Crown']['award']}'
                                                  : '${0}',
                                              icon: data['RP'] >=
                                                      int.parse(data1['Crown']
                                                          ['rankpoints'])
                                                  ? Icons.done
                                                  : Icons.account_tree_rounded,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Double Crown
                                      Visibility(
                                        visible: data['RP'] >=
                                                int.parse(data1['Crown']
                                                    ['rankpoints'])
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kPrimaryClr
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: MYrpLevelCard(
                                              level: 'Double Crown',
                                              rp: '${data['RP']}',
                                              award: data['RP'] >=
                                                      int.parse(
                                                          data1['Double Crown']
                                                              ['rankpoints'])
                                                  ? '${data1['Double Crown']['award']}'
                                                  : '${0}',
                                              icon: data['RP'] >=
                                                      int.parse(
                                                          data1['Double Crown']
                                                              ['rankpoints'])
                                                  ? Icons.done
                                                  : Icons.account_tree_rounded,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Star
                                      Visibility(
                                        visible: data['RP'] >=
                                                int.parse(data1['Double Crown']
                                                    ['rankpoints'])
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kPrimaryClr
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: MYrpLevelCard(
                                              level: 'Star',
                                              rp: '${data['RP']}',
                                              award: data['RP'] >=
                                                      int.parse(data1['Star']
                                                          ['rankpoints'])
                                                  ? '${data1['Star']['award']}'
                                                  : '${0}',
                                              icon: data['RP'] >=
                                                      int.parse(data1['Star']
                                                          ['rankpoints'])
                                                  ? Icons.done
                                                  : Icons.account_tree_rounded,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Double Star
                                      Visibility(
                                        visible: data['RP'] >=
                                                int.parse(
                                                    data1['Star']['rankpoints'])
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kPrimaryClr
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: MYrpLevelCard(
                                              level: 'Double Star',
                                              rp: '${data['RP']}',
                                              award: data['RP'] >=
                                                      int.parse(
                                                          data1['Double Star']
                                                              ['rankpoints'])
                                                  ? '${data1['Double Star']['award']}'
                                                  : '${0}',
                                              icon: data['RP'] >=
                                                      int.parse(
                                                          data1['Double Star']
                                                              ['rankpoints'])
                                                  ? Icons.done
                                                  : Icons.account_tree_rounded,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Super Star
                                      Visibility(
                                        visible: data['RP'] >=
                                                int.parse(data1['Double Star']
                                                    ['rankpoints'])
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kPrimaryClr
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: MYrpLevelCard(
                                              level: 'Super Star',
                                              rp: '${data['RP']}',
                                              award: data['RP'] >=
                                                      int.parse(
                                                          data1['Super Star']
                                                              ['rankpoints'])
                                                  ? '${data1['Super Star']['award']}'
                                                  : '${0}',
                                              icon: data['RP'] >=
                                                      int.parse(
                                                          data1['Super Star']
                                                              ['rankpoints'])
                                                  ? Icons.done
                                                  : Icons.account_tree_rounded,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Royal
                                      Visibility(
                                        visible: data['RP'] >=
                                                int.parse(data1['Super Star']
                                                    ['rankpoints'])
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kPrimaryClr
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: MYrpLevelCard(
                                              level: 'Royal',
                                              rp: '${data['RP']}',
                                              award: data['RP'] >=
                                                      int.parse(data1['Royal']
                                                          ['rankpoints'])
                                                  ? '${data1['Royal']['award']}'
                                                  : '${0}',
                                              icon: data['RP'] >=
                                                      int.parse(data1['Royal']
                                                          ['rankpoints'])
                                                  ? Icons.done
                                                  : Icons.account_tree_rounded,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Royal Achiever
                                      Visibility(
                                        visible: data['RP'] >=
                                                int.parse(data1['Royal']
                                                    ['rankpoints'])
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kPrimaryClr
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: MYrpLevelCard(
                                              level: 'Royal Achiever',
                                              rp: '${data['RP']}',
                                              award: data['RP'] >=
                                                      int.parse(data1[
                                                              'Royal Achiever']
                                                          ['rankpoints'])
                                                  ? '${data1['Royal Achiever']['award']}'
                                                  : '${0}',
                                              icon: data['RP'] >=
                                                      int.parse(data1[
                                                              'Royal Achiever']
                                                          ['rankpoints'])
                                                  ? Icons.done
                                                  : Icons.account_tree_rounded,
                                            ),
                                          ),
                                        ),
                                      ),
                                      30.height,
                                      MyButton(
                                          title: "Add to Wallet",
                                          press: () {
                                            CollectionReference earn =
                                                FirebaseFirestore.instance
                                                    .collection('usersIncome');
                                            CollectionReference rankup =
                                                FirebaseFirestore.instance
                                                    .collection('RanksPay');

                                            rankup
                                                .doc(box.read("uid"))
                                                .get()
                                                .then((DocumentSnapshot
                                                    documentSnapshot) {
                                              if (documentSnapshot.exists) {
                                                print(
                                                    'Document exists on the database');
                                                earn
                                                    .doc(box.read("uid"))
                                                    .get()
                                                    .then((DocumentSnapshot
                                                        documentSnapshot1) {
                                                  if (documentSnapshot1
                                                      .exists) {
                                                    print(
                                                        'Document exists on the database');

                                                    //========distrubuter

                                                    if (data['RP'] >=
                                                            int.parse(data1[
                                                                    'Distributor']
                                                                [
                                                                'rankpoints']) &&
                                                        documentSnapshot[
                                                                'Distributor'] ==
                                                            true) {
                                                      EasyLoading.show();
                                                      int total = documentSnapshot1[
                                                              'wallet'] +
                                                          int.parse(data1[
                                                                  'Distributor']
                                                              ['award']);
                                                      earn
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'wallet': total,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                      rankup
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'Distributor':
                                                                false,
                                                            'Silver': true,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                    }

                                                    //================================
                                                    //========Silver

                                                    if (data['RP'] >=
                                                            int.parse(data1[
                                                                    'Silver'][
                                                                'rankpoints']) &&
                                                        documentSnapshot[
                                                                'Silver'] ==
                                                            true) {
                                                      EasyLoading.show();
                                                      int total =
                                                          documentSnapshot1[
                                                                  'wallet'] +
                                                              int.parse(data1[
                                                                      'Silver']
                                                                  ['award']);
                                                      earn
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'wallet': total,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                      rankup
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'Silver': false,
                                                            'Gold': true,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                    }

                                                    //================================
                                                    //========Gold

                                                    if (data['RP'] >=
                                                            int.parse(data1[
                                                                    'Gold'][
                                                                'rankpoints']) &&
                                                        documentSnapshot[
                                                                'Gold'] ==
                                                            true) {
                                                      EasyLoading.show();
                                                      int total =
                                                          documentSnapshot1[
                                                                  'wallet'] +
                                                              int.parse(data1[
                                                                      'Gold']
                                                                  ['award']);
                                                      earn
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'wallet': total,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                      rankup
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'Platinum': true,
                                                            'Gold': false,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                    }

                                                    //================================
                                                    //========Platinum

                                                    if (data['RP'] >=
                                                            int.parse(data1[
                                                                    'Platinum'][
                                                                'rankpoints']) &&
                                                        documentSnapshot[
                                                                'Platinum'] ==
                                                            true) {
                                                      EasyLoading.show();
                                                      int total =
                                                          documentSnapshot1[
                                                                  'wallet'] +
                                                              int.parse(data1[
                                                                      'Platinum']
                                                                  ['award']);
                                                      earn
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'wallet': total,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                      rankup
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'Platinum': false,
                                                            'Diamond': true,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                    }

                                                    //================================
                                                    //========Diamond

                                                    if (data['RP'] >=
                                                            int.parse(data1[
                                                                    'Diamond'][
                                                                'rankpoints']) &&
                                                        documentSnapshot[
                                                                'Diamond'] ==
                                                            true) {
                                                      EasyLoading.show();
                                                      int total =
                                                          documentSnapshot1[
                                                                  'wallet'] +
                                                              int.parse(data1[
                                                                      'Diamond']
                                                                  ['award']);
                                                      earn
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'wallet': total,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                      rankup
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'Crown': true,
                                                            'Diamond': false,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                    }

                                                    //================================
                                                    //========Crown

                                                    if (data['RP'] >=
                                                            int.parse(data1[
                                                                    'Crown'][
                                                                'rankpoints']) &&
                                                        documentSnapshot[
                                                                'Crown'] ==
                                                            true) {
                                                      EasyLoading.show();
                                                      int total =
                                                          documentSnapshot1[
                                                                  'wallet'] +
                                                              int.parse(data1[
                                                                      'Crown']
                                                                  ['award']);
                                                      earn
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'wallet': total,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                      rankup
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'Crown': false,
                                                            'Double Crown':
                                                                true,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                    }

                                                    //================================
                                                    //========Double Crown

                                                    if (data['RP'] >=
                                                            int.parse(data1[
                                                                    'Double Crown']
                                                                [
                                                                'rankpoints']) &&
                                                        documentSnapshot[
                                                                'Double Crown'] ==
                                                            true) {
                                                      EasyLoading.show();
                                                      int total = documentSnapshot1[
                                                              'wallet'] +
                                                          int.parse(data1[
                                                                  'Double Crown']
                                                              ['award']);
                                                      earn
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'wallet': total,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                      rankup
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'Star': true,
                                                            'Double Crown':
                                                                false,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                    }

                                                    //================================
                                                    //========Star

                                                    if (data['RP'] >=
                                                            int.parse(data1[
                                                                    'Star'][
                                                                'rankpoints']) &&
                                                        documentSnapshot[
                                                                'Star'] ==
                                                            true) {
                                                      EasyLoading.show();
                                                      int total =
                                                          documentSnapshot1[
                                                                  'wallet'] +
                                                              int.parse(data1[
                                                                      'Star']
                                                                  ['award']);
                                                      earn
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'wallet': total,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                      rankup
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'Double Star': true,
                                                            'Star': false,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                    }

                                                    //================================
                                                    //========Double Star

                                                    if (data['RP'] >=
                                                            int.parse(data1[
                                                                    'Double Star']
                                                                [
                                                                'rankpoints']) &&
                                                        documentSnapshot[
                                                                'Double Star'] ==
                                                            true) {
                                                      EasyLoading.show();
                                                      int total = documentSnapshot1[
                                                              'wallet'] +
                                                          int.parse(data1[
                                                                  'Double Star']
                                                              ['award']);
                                                      earn
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'wallet': total,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                      rankup
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'Double Star':
                                                                false,
                                                            'Super Star': true,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                    }

                                                    //================================
                                                    //========Super Star Star

                                                    if (data['RP'] >=
                                                            int.parse(data1[
                                                                    'Super Star']
                                                                [
                                                                'rankpoints']) &&
                                                        documentSnapshot[
                                                                'Super Star'] ==
                                                            true) {
                                                      EasyLoading.show();
                                                      int total =
                                                          documentSnapshot1[
                                                                  'wallet'] +
                                                              int.parse(data1[
                                                                      'Super Star']
                                                                  ['award']);
                                                      earn
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'wallet': total,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                      rankup
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'Super Star': false,
                                                            'Royal': true,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                    }

                                                    //================================
                                                    //========Royal

                                                    if (data['RP'] >=
                                                            int.parse(data1[
                                                                    'Royal'][
                                                                'rankpoints']) &&
                                                        documentSnapshot[
                                                                'Royal'] ==
                                                            true) {
                                                      EasyLoading.show();
                                                      int total =
                                                          documentSnapshot1[
                                                                  'wallet'] +
                                                              int.parse(data1[
                                                                      'Royal']
                                                                  ['award']);
                                                      earn
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'wallet': total,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                      rankup
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'Royal': false,
                                                            'Royal Achiever':
                                                                true,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                    }

                                                    //================================
                                                    //========Royal

                                                    if (data['RP'] >=
                                                            int.parse(data1[
                                                                    'Royal Achiever']
                                                                [
                                                                'rankpoints']) &&
                                                        documentSnapshot[
                                                                'Royal Achiever'] ==
                                                            true) {
                                                      EasyLoading.show();
                                                      int total = documentSnapshot1[
                                                              'wallet'] +
                                                          int.parse(data1[
                                                                  'Royal Achiever']
                                                              ['award']);
                                                      earn
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'wallet': total,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                      rankup
                                                          .doc(box.read("uid"))
                                                          .update({
                                                            'Royal Achiever':
                                                                false,
                                                          })
                                                          .whenComplete(() =>
                                                              EasyLoading
                                                                  .dismiss())
                                                          .then((value) => print(
                                                              "User Updated"))
                                                          .catchError((error) =>
                                                              print(
                                                                  "Failed to update user: $error"));
                                                    }

                                                    //================================
                                                  }
                                                });
                                              }
                                            });
                                          })
                                    ],
                                  );
                                }

                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            );
                          }).toList(),
                        );
                      },
                    )
                  ])))
        ]));
  }
}

class MYrpLevelCard extends StatelessWidget {
  final String level, rp, award;
  final IconData icon;
  const MYrpLevelCard({
    Key? key,
    required this.level,
    required this.rp,
    required this.award,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: _size.width >= 570 ? 150 : 80,
            child: Text(level,
                style: TextStyle(fontSize: _size.width >= 570 ? 18 : 14.0)),
          ),
          SizedBox(
            width: _size.width >= 570 ? 110 : 80,
            child: Text(rp,
                style: TextStyle(fontSize: _size.width >= 570 ? 18 : 14.0)),
          ),
          Container(
            child: Text(award,
                style: TextStyle(fontSize: _size.width >= 570 ? 18 : 12.0)),
          ),
        ],
      ),
      trailing: Icon(
        icon,
        color: kPrimaryClr,
      ),
    );
  }
}
