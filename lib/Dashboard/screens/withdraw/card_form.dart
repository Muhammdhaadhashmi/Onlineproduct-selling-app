import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onicame/Dashboard/screens/withdraw/withdrawscreen.dart';
import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';

class CardFormScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const CardFormScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<CardFormScreen> createState() => _CardFormScreenState();
}

class _CardFormScreenState extends State<CardFormScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController cvvCode = TextEditingController();

  TextEditingController cardNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Please Provide Card Details to Withdraw.",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          10.height,
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: kSecondarClr),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CustomInputFormatter()
                ],
                maxLength: 19,
                controller: cardNumber,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  labelStyle: TextStyle(color: kSecondarClr),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          20.height,
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: kSecondarClr),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: cvvCode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Cvv Code',
                  labelStyle: TextStyle(color: kSecondarClr),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          30.height,
          MaterialButton(
            color: kprimaryClr,
            height: 60,
            minWidth: double.maxFinite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const Text(
              'Next',
              style: TextStyle(color: kwhiteClr, fontSize: 15),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                EasyLoading.show();
                FirebaseFirestore.instance
                    .collection('mastercard')
                    .where('uid', isEqualTo: box.read('uid'))
                    .get()
                    .then((QuerySnapshot querySnapshot) {
                  for (var doc in querySnapshot.docs) {
                    print(doc.exists);

                    if (doc['num'] == cardNumber.text.toString() &&
                        doc['cvvCode'] == cvvCode.text.toString()) {
                      if (widget.data['panding'] == false) {
                        if (widget.data['wallet'] >= 300) {
                          EasyLoading.dismiss();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ApplyWithdrawn(
                                    amnt: widget.data['wallet']);
                              });
                        } else {
                          EasyLoading.dismiss();
                          toasty(
                            context,
                            "You have insufficient balance to withdraw.",
                            borderRadius: radius(),
                            bgColor: appButtonColor,
                            textColor: primaryColor,
                            gravity: ToastGravity.TOP,
                          );
                        }
                      }
                    } else {
                      EasyLoading.dismiss();
                      toasty(
                        context,
                        "Invalid Informaton",
                        borderRadius: radius(),
                        bgColor: appButtonColor,
                        textColor: primaryColor,
                        gravity: ToastGravity.TOP,
                      );
                    }
                  }
                });
              }
            },
          ),
          20.height,
        ],
      ),
    );
  }
}
