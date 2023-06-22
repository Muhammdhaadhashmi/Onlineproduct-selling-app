import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:onicame/Dashboard/components/usersidebar.dart';
import 'package:onicame/Dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:onicame/admin/active_buyer.dart';
import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class WithDrawScreen extends StatefulWidget {
  static const String id = '/withdraw';
  const WithDrawScreen({Key? key}) : super(key: key);

  @override
  _WithDrawScreenState createState() => _WithDrawScreenState();
}

class _WithDrawScreenState extends State<WithDrawScreen> {
  CollectionReference users =
      FirebaseFirestore.instance.collection('usersIncome');
  bool active = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController cvvCode = TextEditingController();

  TextEditingController cardNumber = TextEditingController();
  isActiveorNote() {
    setState(() {
      FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: box.read('uid'))
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["active"] == true) {
            setState(() {
              active = true;
            });
          }
        }
      });
    });
  }

  bool nocard = false;
  bool waitcard = false;
  bool exist = false;

  @override
  void initState() {
    isActiveorNote();
    FirebaseFirestore.instance
        .collection('mastercard')
        .doc(box.read('uid'))
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          exist = true;
        });
      } else {
        setState(() {
          nocard = true;
          waitcard = false;
        });
      }
    });
    super.initState();
  }

  bool show = false;
  final streamdata = FirebaseFirestore.instance
      .collection('usersIncome')
      .where('userid', isEqualTo: box.read('uid'))
      .snapshots();
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
              child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Withdraw",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: streamdata,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading");
                            }

                            return Column(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                return Column(
                                  children: [
                                    Wrap(
                                      children: [
                                        BlockContainer(
                                            title: "Withdrawn",
                                            description:
                                                "${data['withdrawn']} PKR"),
                                        30.height,
                                        BlockContainer(
                                            title: data['panding'] == false
                                                ? "Available for Withdrawal"
                                                : "Pending",
                                            description:
                                                data['panding'] == false
                                                    ? "${data['wallet']} PKR"
                                                    : "Please wait"),
                                      ],
                                    ),
                                    30.height,
                                    if (active == false)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MyButton(
                                              title:
                                                  "Please purchase Mastercard to withdraw.",
                                              press: () {
                                                (context)
                                                    .goNamed('my-master-card');
                                              }),
                                        ),
                                      ),
                                    //files

                                    if (active == true && exist == true)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Please Provide Card Details to Withdraw.",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            10.height,
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: kSecondarClr),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    CustomInputFormatter()
                                                  ],
                                                  maxLength: 19,
                                                  controller: cardNumber,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Required';
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Card Number',
                                                    labelStyle: TextStyle(
                                                        color: kSecondarClr),
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            20.height,
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: kSecondarClr),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: TextFormField(
                                                  controller: cvvCode,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Required';
                                                    }
                                                    return null;
                                                  },
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Cvv Code',
                                                    labelStyle: TextStyle(
                                                        color: kSecondarClr),
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            30.height,
                                            MaterialButton(
                                              color: kprimaryClr,
                                              height: 60,
                                              minWidth: double.maxFinite,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: const Text(
                                                'Next',
                                                style: TextStyle(
                                                    color: kwhiteClr,
                                                    fontSize: 15),
                                              ),
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  EasyLoading.show();
                                                  FirebaseFirestore.instance
                                                      .collection('mastercard')
                                                      .where('uid',
                                                          isEqualTo:
                                                              box.read('uid'))
                                                      .get()
                                                      .then((QuerySnapshot
                                                          querySnapshot) {
                                                    for (var doc
                                                        in querySnapshot.docs) {
                                                      print(doc.exists);

                                                      if (doc['num'] ==
                                                              cardNumber.text
                                                                  .toString() &&
                                                          doc['cvvCode'] ==
                                                              cvvCode.text
                                                                  .toString()) {
                                                        if (data['panding'] ==
                                                            false) {
                                                          if (data['wallet'] >=
                                                              300) {
                                                            EasyLoading
                                                                .dismiss();
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return ApplyWithdrawn(
                                                                      amnt: data[
                                                                          'wallet']);
                                                                });
                                                          } else {
                                                            EasyLoading
                                                                .dismiss();
                                                            toasty(
                                                              context,
                                                              "You have insufficient balance to withdraw.",
                                                              borderRadius:
                                                                  radius(),
                                                              bgColor:
                                                                  appButtonColor,
                                                              textColor:
                                                                  primaryColor,
                                                              gravity:
                                                                  ToastGravity
                                                                      .TOP,
                                                            );
                                                          }
                                                        }
                                                      } else {
                                                        EasyLoading.dismiss();
                                                        toasty(
                                                          context,
                                                          "Invalid Informaton",
                                                          borderRadius:
                                                              radius(),
                                                          bgColor:
                                                              appButtonColor,
                                                          textColor:
                                                              primaryColor,
                                                          gravity:
                                                              ToastGravity.TOP,
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
                                      ),
                                  ],
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ]));
  }
}

class ApplyWithdrawn extends StatefulWidget {
  final int amnt;
  const ApplyWithdrawn({
    Key? key,
    required this.amnt,
  }) : super(key: key);

  @override
  _ApplyWithdrawnState createState() => _ApplyWithdrawnState();
}

class _ApplyWithdrawnState extends State<ApplyWithdrawn> {
  CollectionReference withdraw =
      FirebaseFirestore.instance.collection('applyuserdrawn');
  CollectionReference incomeuser =
      FirebaseFirestore.instance.collection('usersIncome');
  final _formKey = GlobalKey<FormState>();

  var numberController = TextEditingController();
  var accountnameController = TextEditingController();
  var amountController = TextEditingController();

  String _titlename = "JazzCash";
  List<String> titlenameList = [
    'JazzCash',
    'EasyPaisa',
    'Bank',
  ];
  addUser() {
    // Call the user's CollectionReference to add a new user
    return withdraw
        .doc(box.read("uid"))
        .set({
          "uid": box.read("uid"),
          "name": box.read("firstName"),
          'accountname': accountnameController.text,
          'method': _titlename,
          'amount': amountController.text,
          'number': numberController.text,
        })
        .then((value) => print("User Added"))
        .whenComplete(() => updatepending())
        .whenComplete(() => EasyLoading.dismiss())
        .catchError((error) => print("Failed to add user: $error"))
        .whenComplete(() => EasyLoading.dismiss());
  }

  updatepending() {
    return incomeuser
        .doc(box.read("uid"))
        .update({'panding': true})
        .then((value) => print("User Updated"))
        .whenComplete(() => (context).goNamed('dashboard'))
        .catchError((error) => print("Failed to update user: $error"));
  }

  income() {
    FirebaseFirestore.instance
        .collection('usersIncome')
        .doc(box.read("uid"))
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        int total =
            documentSnapshot['withdrawn'] + int.parse(amountController.text);
        int min = documentSnapshot['wallet'] - int.parse(amountController.text);
        return incomeuser
            .doc(box.read("uid"))
            .update({
              'wallet': min,
              'withdrawn': total,
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }
    });
    // Call the user's CollectionReference to add a new user
  }

  addtoadmin() {
    CollectionReference incon =
        FirebaseFirestore.instance.collection('adminincome');
    FirebaseFirestore.instance
        .collection('adminincome')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        int total = doc['wallet'] + int.parse(amountController.text);

        incon
            .doc('1tFg1zFDRrU0lqpiokiWre4Rl053')
            .update({
              'wallet': total,
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      readOnly: true,
                      decoration: fieldDecration(
                          hint: _titlename,
                          icon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text(_titlename),
                              focusColor: kPrimaryClr,
                              underline: Container(
                                height: 0,
                                color: Colors.transparent,
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _titlename = newValue!;
                                });
                              },
                              items: titlenameList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        value.toString(),
                                        style:
                                            const TextStyle(color: kPrimaryClr),
                                      ),
                                    ));
                              }).toList(),
                            ),
                          ),
                          title: "Select Payment Method",
                          isalways: true),
                    ),
                  ),
                  20.height,
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: numberController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      decoration: fieldDecration(
                          hint: "$_titlename Number",
                          icon: const Icon(Icons.production_quantity_limits),
                          title: "$_titlename Number"),
                    ),
                  ),
                  20.height,
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: accountnameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      decoration: fieldDecration(
                          hint: "Enter Account Name",
                          icon: const Icon(Icons.production_quantity_limits),
                          title: "Account Name"),
                    ),
                  ),
                  20.height,
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: amountController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      decoration: fieldDecration(
                          hint: "Amount",
                          icon: const Icon(Icons.production_quantity_limits),
                          title: "Amount"),
                    ),
                  ),
                  20.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: MaterialButton(
                      color: kPrimaryClr,
                      height: 60,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (int.parse(amountController.text) >= 300) {
                            if (widget.amnt >=
                                int.parse(amountController.text)) {
                              EasyLoading.show();
                              addUser();
                            } else {
                              toasty(
                                context,
                                "InCorrect Value",
                                borderRadius: radius(),
                                bgColor: appButtonColor,
                                textColor: primaryColor,
                                gravity: ToastGravity.TOP,
                              );
                            }
                          } else {
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
                      },
                      child: const Text(
                        "proceed",
                        style: TextStyle(
                            color: kWhiteClr,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(
            ' '); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
