import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onicame/Dashboard/components/usersidebar.dart';
import 'package:onicame/Dashboard/screens/mastercard/widget/buy_screen.dart';
import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';

import '../../../utils/constants.dart';

class MyMasterCard extends StatefulWidget {
  static const String id = '/mastercard';
  const MyMasterCard({Key? key}) : super(key: key);

  @override
  State<MyMasterCard> createState() => _MyMasterCardState();
}

class _MyMasterCardState extends State<MyMasterCard> {
  String cardid = '';
  bool nocard = false;
  bool waitcard = false;
  bool exist = false;
  String name = '';
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('mastercard')
        .doc(box.read('uid'))
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          exist = true;
          cardNumber = documentSnapshot.get(FieldPath(const ['num']));
          cvvCode = documentSnapshot.get(FieldPath(const ['cvvCode']));
        });
      } else {
        setState(() {
          nocard = true;
          waitcard = false;
        });
      }
    });
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: box.read('uid'))
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {});
        cardHolderName = doc['username'];
        if (doc['buy'] == true) {
          setState(() {
            waitcard = true;
          });
        }
      }
    });
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  String cardNumber = '';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (waitcard)
                  const Text(
                      "Please wait while the activation is under review."),
                10.height,
                if (nocard && waitcard == false)
                  MaterialButton(
                    color: kprimaryClr,
                    height: 55,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const PurchaseCard();
                          });
                    },
                    child: const Text(
                      "Purchase Card",
                      style: TextStyle(color: kwhiteClr),
                    ),
                  ),
                if (exist)
                  CreditCardWidget(
                    glassmorphismConfig:
                        useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    bankName: 'Onicame',
                    showBackView: isCvvFocused,
                    obscureCardNumber: false,
                    obscureCardCvv: false,
                    isHolderNameVisible: true,
                    cardBgColor: Colors.red,
                    backgroundImage:
                        useBackgroundImage ? 'images/assets/card_bg.png' : null,
                    isSwipeGestureEnabled: true,
                    onCreditCardWidgetChange:
                        (CreditCardBrand creditCardBrand) {},
                    customCardTypeIcons: <CustomCardTypeIcon>[
                      CustomCardTypeIcon(
                        cardType: CardType.mastercard,
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
          )
        ]));
  }
}
