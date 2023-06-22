import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:get/get.dart';
import 'package:onicame/admin/components/viewinactive.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import 'components/side_menu.dart';

class CardLists extends StatefulWidget {
  const CardLists({Key? key}) : super(key: key);

  @override
  _CardListsState createState() => _CardListsState();
}

class _CardListsState extends State<CardLists> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('mastercard').snapshots();
  TextEditingController activeid = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  CollectionReference usersdelete =
      FirebaseFirestore.instance.collection('mastercard');

  Future<void> deleteUser(String id) {
    return usersdelete
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  String expiryDate = '04/27';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }

                    return ListView(
                      children: [
                        Column(
                          children: [
                            20.height,
                            Column(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data1 =
                                    document.data()! as Map<String, dynamic>;
                                return FutureBuilder<DocumentSnapshot>(
                                  future: users.doc(data1['uid']).get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasError) {
                                      return Text("Something went wrong");
                                    }

                                    if (snapshot.hasData &&
                                        !snapshot.data!.exists) {
                                      return Text("Document does not exist");
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      Map<String, dynamic> data = snapshot.data!
                                          .data() as Map<String, dynamic>;
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: kgrayClr.withOpacity(0.2),
                                          ),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    cardHolderName =
                                                        data["username"];
                                                  });
                                                },
                                                title: Text(data["username"]),
                                              ),
                                              if (data["username"] ==
                                                  cardHolderName)
                                                CreditCardWidget(
                                                  glassmorphismConfig:
                                                      useGlassMorphism
                                                          ? Glassmorphism
                                                              .defaultConfig()
                                                          : null,
                                                  cardNumber:
                                                      data1['num'].toString(),
                                                  expiryDate: expiryDate,
                                                  cardHolderName:
                                                      data["username"],
                                                  cvvCode: data1['cvvCode']
                                                      .toString(),
                                                  bankName: 'Onicame',
                                                  showBackView: isCvvFocused,
                                                  obscureCardNumber: false,
                                                  obscureCardCvv: false,
                                                  isHolderNameVisible: true,
                                                  cardBgColor: Colors.red,
                                                  backgroundImage:
                                                      useBackgroundImage
                                                          ? 'images/assets/card_bg.png'
                                                          : null,
                                                  isSwipeGestureEnabled: true,
                                                  onCreditCardWidgetChange:
                                                      (CreditCardBrand
                                                          creditCardBrand) {},
                                                  customCardTypeIcons: <
                                                      CustomCardTypeIcon>[
                                                    CustomCardTypeIcon(
                                                      cardType:
                                                          CardType.mastercard,
                                                      cardImage: Image.asset(
                                                        'assets/mastercard.png',
                                                        height: 48,
                                                        width: 48,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }

                                    return Text("loading");
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ))
        ],
      ),
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

class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback press;
  const MyButton({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: kPrimaryClr,
      minWidth: double.infinity,
      height: 60,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      onPressed: press,
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, color: kWhiteClr),
      ),
    );
  }
}
