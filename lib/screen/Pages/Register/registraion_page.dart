import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onicame/admin/components/side_menu.dart';
import 'package:onicame/screen/Pages/footer/our_footer.dart';
import 'package:onicame/screen/Pages/modules/widgets/navigation_bar.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/enums.dart';

class RegistrationPage extends StatefulWidget {
  final String? data;
  const RegistrationPage({Key? key, this.data}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  var email = '';
  var password = '';
  var username = '';
  var sponsernamename = '';
  var title = '';
  var cnic = '';
  var datebirth = '';
  var countryname = '';
  var statename = '';
  var addressname = '';
  var pnumber = '';
  var fuser = '';
  var luser = '';
  var stateTextController = TextEditingController();
  var addressTextController = TextEditingController();
  FocusNode addressText = FocusNode();
  var datebirthTextController = TextEditingController();
  FocusNode datebirthText = FocusNode();
  var lastnameTextController = TextEditingController();
  FocusNode lastnameText = FocusNode();
  var cnicTextController = TextEditingController();
  FocusNode cnicText = FocusNode();
  var firstnameTextController = TextEditingController();
  FocusNode firstnameText = FocusNode();
  var sponsernameTextController = TextEditingController();
  FocusNode sponsernameText = FocusNode();
  var emailTextController = TextEditingController();
  FocusNode emailText = FocusNode();
  var usernameTextController = TextEditingController();
  FocusNode usernameText = FocusNode();
  var passwordTextController = TextEditingController();
  FocusNode passwordText = FocusNode();
  var mobTextController = TextEditingController();
  FocusNode mobText = FocusNode();
  var confirmpasswordTextController = TextEditingController();
  FocusNode confirmpasswordText = FocusNode();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.data.toString())
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          sponsernameTextController.text =
              documentSnapshot.get(FieldPath(const ['username']));
        }
      });
    });
    super.initState();
  }

  bool isvisible = true;
  bool iscvisible = true;
  bool confirmisvisible = true;
  String _titlename = "Mr.";
  List<String> titlenameList = [
    'Mr.',
    'Miss.',
    'Mrs.',
    'Ms.',
  ];
  DateTime _selectedDate = DateTime.now();
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  bool ischeck = false;
  bool ischeck2 = false;
  bool ischeck3 = false;
  int spon = 0;
  int user = 0;
  //================create account=============================\
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  submit(String a) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text,
        );

        // Call the user's CollectionReference to add a new user
        return users
            .doc(a)
            .set({
              'uid': a,
              'verify': false,
              'invoice': "",
              'sponsorname':
                  auvisl == false ? "onicame" : sponsernameTextController.text,
              "firstName": firstnameTextController.text,
              'lastname': lastnameTextController.text,
              'username': usernameTextController.text,
              "email": emailTextController.text,
              'cnicNo': cnicTextController.text,
              'dateofbirth': datebirth,
              'country': countryname,
              'state': statename,
              'address': addressTextController.text,
              'title': _titlename,
              'mobileno': mobTextController.text,
              'photoUrl': "",
              'isEmailLogin': true,
              'password': passwordTextController.text,
              'isTester': false,
              'active': false,
              'sponsorcode': spon,
              'usercode': int.parse(a),
              'userRole': "admin",
              'createdAt': Timestamp.now(),
              'updatedAt': Timestamp.now(),
            })
            .then((value) {
              CollectionReference income =
                  FirebaseFirestore.instance.collection('usersIncome');
              User? curtUser = FirebaseAuth.instance.currentUser;
              int total = int.parse('0');
              return income.doc(a).set({
                'userid': a,
                'username': usernameTextController.text,
                'RP': total,
                "wallet": total,
                "level1": total,
                "level2": total,
                "level3": total,
                "level4": total,
                "level5": total,
                "level6": total,
                "level7": total,
                "level8": total,
                "level9": total,
                'panding': false,
                'image': "",
                'withdrawn': total,
              }).then((value) => FirebaseFirestore.instance
                  .collection('RanksPay')
                  .doc(a)
                  .set({
                    'name': usernameTextController.text,
                    'uid': a,
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
                  .then((value) => FirebaseFirestore.instance
                      .collection('history')
                      .doc(a)
                      .set({
                        'name': usernameTextController.text,
                        'uid': a,
                      })
                      .then((value) => print("User Added"))
                      .catchError(
                          (error) => print("Failed to add user: $error")))
                  .catchError((error) => print("Failed to add user: $error"))
                  .whenComplete(() => EasyLoading.dismiss())
                  .then((value) => print("User Added")));
            })
            .then((value) => print("User Added"))
            .whenComplete(() => GoRouter.of(context).go('/login'))
            .catchError((error) => print("Failed to add user: $error"))
            .whenComplete(() => EasyLoading.dismiss());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          toasty(
            context,
            "The password provided is too weak.",
            borderRadius: radius(),
            bgColor: appButtonColor,
            textColor: primaryColor,
            gravity: ToastGravity.TOP,
          );
          EasyLoading.dismiss();
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          toasty(
            context,
            "The account already exists for that email.",
            borderRadius: radius(),
            bgColor: appButtonColor,
            textColor: primaryColor,
            gravity: ToastGravity.TOP,
          );
          EasyLoading.dismiss();
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
        EasyLoading.dismiss();
      }

      // appStore.setIsLoading(true);
    }
  }

  bool auvisl = false;
  bool nuvisl = false;
  bool newauvisl = false;
  bool newnuvisl = false;
  bool isvlid = false;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Drawer(
        child: Draweuser(),
      ),
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: _size.width >= 786 ? false : true,
        backgroundColor: kWhiteClr,
        title: const NavContainer(
          select: MenuState.registration,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const PageLabel(
                    label: "Sign Up",
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: kMaxWidth,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            //supsor name=====================
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: sponsernameTextController,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.none,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[-@._0-9a-z]")),
                                  LengthLimitingTextInputFormatter(36),
                                ],
                                onChanged: (String val) {
                                  setState(() {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .where('username', isEqualTo: val)
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                          for (var doc in querySnapshot.docs) {
                                            setState(() {
                                              auvisl = true;
                                              nuvisl = false;
                                              spon = doc['usercode'];

                                              print(spon);
                                            });
                                          }
                                        })
                                        .whenComplete(() => FirebaseFirestore
                                                .instance
                                                .collection('users')
                                                .get()
                                                .then((QuerySnapshot
                                                    querySnapshot) {
                                              for (var doc
                                                  in querySnapshot.docs) {
                                                setState(() {
                                                  if (doc['username'] != val) {
                                                    auvisl = false;
                                                    nuvisl = true;
                                                  }
                                                });
                                              }
                                            }))
                                        .whenComplete(() => FirebaseFirestore
                                                .instance
                                                .collection('users')
                                                .where('username',
                                                    isEqualTo: val)
                                                .get()
                                                .then((QuerySnapshot
                                                    querySnapshot) {
                                              for (var doc
                                                  in querySnapshot.docs) {
                                                setState(() {
                                                  nuvisl = false;
                                                  auvisl = true;
                                                  spon = doc['usercode'];

                                                  print(spon);
                                                });
                                              }
                                            }));
                                  });
                                },
                                decoration: fieldDecration(
                                    hint:
                                        "Enter Sponsor's name in small letters",
                                    icon: const Icon(Icons.person),
                                    title: "Sponsor's name"),
                              ),
                            ),
                            Visibility(
                                visible: auvisl,
                                child: const Text("Sponsor name availble")),
                            Visibility(
                                visible: nuvisl,
                                child: const Text(
                                  "Sponsor name not availble",
                                  style: TextStyle(color: Colors.red),
                                )),

                            16.height,
                            //title

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: TextFormField(
                                readOnly: true,
                                decoration: fieldDecration(
                                    hint: _titlename,
                                    icon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        hint: Text(_titlename),
                                        focusColor: kPrimaryClr,
                                        underline: Container(
                                          height: 0,
                                          color: Colors.transparent,
                                        ),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  value.toString(),
                                                  style: const TextStyle(
                                                      color: kPrimaryClr),
                                                ),
                                              ));
                                        }).toList(),
                                      ),
                                    ),
                                    title: "Title",
                                    isalways: true),
                              ),
                            ),
                            //first name
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: firstnameTextController,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter First Name";
                                  }
                                  return null;
                                },
                                decoration: fieldDecration(
                                    hint: "Enter Your First Name",
                                    icon: const Icon(Icons.person),
                                    title: "First Name"),
                              ),
                            ),
                            const SizedBox(
                              height: 2.5,
                            ),
                            const Text(
                              "Please enter your First Name as it appears on your photo ID",
                            ),

                            //last name
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: lastnameTextController,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Last Name";
                                  }
                                  return null;
                                },
                                decoration: fieldDecration(
                                    hint: "Enter Your Last Name",
                                    icon: const Icon(Icons.person),
                                    title: "Last Name"),
                              ),
                            ),
                            const SizedBox(
                              height: 2.5,
                            ),
                            const Text(
                              "Please enter your Last Name as it appears on your photo ID",
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: usernameTextController,
                                keyboardType: TextInputType.name,
                                onChanged: (String val) {
                                  setState(() {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .where('username', isEqualTo: val)
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                          for (var doc in querySnapshot.docs) {
                                            setState(() {
                                              newauvisl = false;
                                              newnuvisl = true;
                                            });
                                          }
                                        })
                                        .whenComplete(() => FirebaseFirestore
                                                .instance
                                                .collection('users')
                                                .get()
                                                .then((QuerySnapshot
                                                    querySnapshot) {
                                              for (var doc
                                                  in querySnapshot.docs) {
                                                setState(() {
                                                  if (doc['username'] != val) {
                                                    newauvisl = true;
                                                    newnuvisl = false;
                                                    user = querySnapshot
                                                            .docs.length +
                                                        1;
                                                    print(" aval $user");
                                                  }
                                                });
                                              }
                                            }))
                                        .whenComplete(() => FirebaseFirestore
                                                .instance
                                                .collection('users')
                                                .where('username',
                                                    isEqualTo: val)
                                                .get()
                                                .then((QuerySnapshot
                                                    querySnapshot) {
                                              for (var doc
                                                  in querySnapshot.docs) {
                                                setState(() {
                                                  newnuvisl = true;
                                                  newauvisl = false;
                                                });
                                              }
                                            }));
                                  });
                                  //   FirebaseFirestore.instance
                                  //       .collection('users')
                                  //       .get()
                                  //       .then((QuerySnapshot querySnapshot) {
                                  //     if (querySnapshot
                                  //             .docs.first['username'] ==
                                  //         val.toLowerCase()) {
                                  //       setState(() {
                                  //         newauvisl = false;
                                  //         newnuvisl = true;
                                  //         print(querySnapshot.docs.length);
                                  //       });
                                  //     } else {
                                  //       setState(() {
                                  //         newauvisl = true;
                                  //         newnuvisl = false;
                                  //       });
                                  //     }
                                  //   });
                                  // });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Username";
                                  }
                                  return null;
                                },
                                textCapitalization: TextCapitalization.none,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[-@._0-9a-z]")),
                                  LengthLimitingTextInputFormatter(36),
                                ],
                                decoration: fieldDecration(
                                    hint: "Enter Username in small letters",
                                    icon: const Icon(Icons.person),
                                    title: "Username"),
                              ),
                            ),
                            Visibility(
                                visible: newauvisl,
                                child: const Text("User name availble")),
                            Visibility(
                                visible: newnuvisl,
                                child: const Text(
                                  "User name not availble",
                                  style: TextStyle(color: Colors.red),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            //email
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: TextFormField(
                                controller: emailTextController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Email";
                                  }
                                  //now we use email validator package
                                  final bool _isvalid = EmailValidator.validate(
                                      emailTextController.text);
                                  if (!_isvalid) {
                                    setState(() {
                                      isvlid = true;
                                    });
                                    return "Email was entered incorrectly";
                                  } else {
                                    setState(() {
                                      isvlid = false;
                                    });
                                  }
                                  return null;
                                },
                                decoration: fieldDecration(
                                    hint: 'Enter Your Email',
                                    icon: const Icon(Icons.email),
                                    title: 'Email'),
                              ),
                            ),

                            //number
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                controller: mobTextController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Mobile No";
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                maxLength: 11,
                                decoration: fieldDecration(
                                    hint: "Enter Your Mobile No",
                                    icon: const Icon(
                                        Icons.format_indent_decrease_rounded),
                                    title: "Mobile No"),
                              ),
                            ),
                            //Id Number
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                controller: cnicTextController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLength: 13,
                                decoration: fieldDecration(
                                    hint: "Enter Your CNIC No",
                                    icon: const Icon(
                                        Icons.format_indent_decrease_rounded),
                                    title: "CNIC No"),
                              ),
                            ),
                            //birthdate
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                readOnly: true,
                                keyboardType: TextInputType.number,
                                decoration: fieldDecration(
                                    hint:
                                        DateFormat.yMd().format(_selectedDate),
                                    icon: IconButton(
                                        onPressed: () {
                                          _getDateFormuser(context);
                                        },
                                        icon: const Icon(Icons.date_range)),
                                    title: "Date of Birth"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //country
                            CSCPicker(
                              flagState: CountryFlag.DISABLE,
                              showCities: false,
                              countryDropdownLabel: 'Country',
                              stateDropdownLabel: 'State',
                              selectedItemStyle: const TextStyle(
                                  color: kPrimaryClr,
                                  fontWeight: FontWeight.w600),
                              onCountryChanged: (convalue) {
                                setState(() {
                                  countryValue = convalue;
                                  print(country.text);
                                });
                              },
                              onStateChanged: (statvalue) {
                                setState(() {
                                  stateValue = statvalue.toString();

                                  print(stateValue);
                                });
                              },
                              onCityChanged: (value) {
                                setState(() {
                                  value = cityValue;
                                });
                              },
                            ),
                            //address
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: TextFormField(
                                controller: addressTextController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Address";
                                  }
                                  //now we use email validator package

                                  return null;
                                },
                                decoration: fieldDecration(
                                    hint: 'Enter Your Address',
                                    icon: const Icon(Icons.email),
                                    title: 'Address'),
                              ),
                            ),
                            //pasword
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                obscureText: isvisible,
                                controller: passwordTextController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Password";
                                  }

                                  return null;
                                },
                                decoration: fieldDecration(
                                    hint: "Enter Your Password",
                                    icon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isvisible = !isvisible;
                                        });
                                      },
                                      icon: isvisible == true
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                      color: isvisible == true
                                          ? kSecondarClr
                                          : kPrimaryClr,
                                    ),
                                    title: "Password"),
                              ),
                            ),
                            //re-enter password
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                obscureText: iscvisible,
                                controller: confirmpasswordTextController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Password";
                                  }
                                  if (passwordTextController.text !=
                                      confirmpasswordTextController.text) {
                                    return "Password not Matched";
                                  }

                                  return null;
                                },
                                decoration: fieldDecration(
                                    hint: "Re-Enter Your Password",
                                    icon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          iscvisible = !iscvisible;
                                        });
                                      },
                                      icon: iscvisible == true
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                      color: iscvisible == true
                                          ? kSecondarClr
                                          : kPrimaryClr,
                                    ),
                                    title: "Re-Enter Password"),
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: ischeck,
                                    activeColor: kPrimaryClr,
                                    shape: const CircleBorder(),
                                    side: const BorderSide(
                                        color: kGreyClr, width: 2),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        ischeck = value!;
                                      });
                                    }),
                                const Expanded(
                                  child: Text(
                                    "I want to subscribe to Onicame marketing communications.",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: ischeck2,
                                    activeColor: kPrimaryClr,
                                    shape: const CircleBorder(),
                                    side: const BorderSide(
                                        color: kGreyClr, width: 2),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        ischeck2 = value!;
                                      });
                                    }),
                                const Expanded(
                                  child: Text(
                                    "I declare that i do not already have an active account with Onicame.",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: ischeck3,
                                    activeColor: kPrimaryClr,
                                    shape: const CircleBorder(),
                                    side: const BorderSide(
                                        color: kGreyClr, width: 2),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        ischeck3 = value!;
                                      });
                                    }),
                                const Expanded(
                                  child: Text(
                                    "I have read and accept the terms of registration.",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                            //sign Up Button
                            Visibility(
                                visible: nuvisl,
                                child: const Text(
                                  "Sponsor name not availble",
                                  style: TextStyle(color: Colors.red),
                                )),
                            Visibility(
                                visible: newnuvisl,
                                child: const Text(
                                  "User name not availble",
                                  style: TextStyle(color: Colors.red),
                                )),
                            Visibility(
                                visible: isvlid,
                                child: const Text(
                                  "Email not valid",
                                  style: TextStyle(color: Colors.red),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                              color: kPrimaryClr,
                              minWidth: double.infinity,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              height: 50,
                              onPressed: () {
                                if (ischeck == true &&
                                    ischeck2 == true &&
                                    ischeck3 == true) {
                                  if (newauvisl == true) {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        datebirth = DateFormat.yMd()
                                            .format(_selectedDate);
                                        statename = stateValue;
                                        countryname = countryValue;
                                        EasyLoading.show();
                                        submit(user.toString());
                                      });
                                    }
                                  }
                                }
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: kWhiteClr,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already a member ?",
                                  style: TextStyle(
                                    color: kSecondarClr,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: kPrimaryClr,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),

            //footor
            const FooterOur(),
          ],
        ),
      ),
    );
  }

  _getDateFormuser(context) async {
    DateTime? _pickdate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2121));
    if (_pickdate != null) {
      setState(() {
        _selectedDate = _pickdate;
        print(_selectedDate);
      });
    } else {
      print("Something went wrong");
    }
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

class PageLabel extends StatelessWidget {
  final String label;
  const PageLabel({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: _size.width >= 550 ? 250 : 100,
      decoration: const BoxDecoration(color: kPrimaryClr),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: _size.width >= 550 ? 30 : 20,
            color: kWhiteClr,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
