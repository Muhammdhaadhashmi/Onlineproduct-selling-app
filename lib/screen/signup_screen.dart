import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onicame/admin/components/side_menu.dart';
import 'package:onicame/component/forgot_password_component.dart';
import 'package:onicame/component/label.dart';
import 'package:onicame/main.dart';
import 'package:onicame/screen/Pages/modules/widgets/navigation_bar.dart';
import 'package:onicame/screen/signup_screen.dart';

import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/enums.dart';
import 'package:onicame/utils/widget.dart';

import 'Pages/footer/our_footer.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController usernameCont = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController confirmPassCont = TextEditingController();

  var sponsernameTextController = TextEditingController();
  FocusNode sponsernameText = FocusNode();

  FocusNode firstNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  FocusNode conformPassFocus = FocusNode();
  bool auvisl = false;
  bool nuvisl = false;
  bool newauvisl = false;
  bool newnuvisl = false;
  bool isvlid = false;

  int spon = 0;
  int user = 0;
  void submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // Map<String, dynamic> data = {
      //   userKeys.firstName: fullNameCont.text,
      //   userKeys.email: emailCont.text,
      //   userKeys.photoUrl: "",
      //   userKeys.isEmailLogin: true,
      //   userKeys.password: passCont.text,
      //   userKeys.isTester: true,
      //   userKeys.userRole: "user",
      //   userKeys.createdAt: Timestamp.now(),
      //   userKeys.updatedAt: Timestamp.now(),
      // };
      // appStore.setIsLoading(true);
      // if (await userService.isUserExist(emailCont.text)) {
      //   toast("User Already Exist, Please sign");
      //   appStore.setIsLoading(false);
      //   finish(context);
      // } else {
      //   authService.signUpWithEmailPassword(userData: data).then((value) {
      //     finish(context);
      //   }).catchError((e) {
      //     toast(e.toString());
      //   }).whenComplete(() => appStore.setIsLoading(false));
      // }
    }
  }
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Drawer(
        child: Draweuser(),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: _size.width >= 786 ? false : true,
        backgroundColor: kWhiteClr,
        title: const NavContainer(
          select: MenuState.login,
        ),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PageLabel(label: "Signup"),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(16),
                width: _size.width >= 550 ? 500 : double.infinity,
                decoration: boxDecorationDefault(),
                child: Column(
                  children: [
                    30.height,
                    32.height,
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
                    // Visibility(
                    //     visible: auvisl,
                    //     child: const Text("Sponsor name availble")),
                    // Visibility(
                    //     visible: nuvisl,
                    //     child: const Text(
                    //       "Sponsor name not availble",
                    //       style: TextStyle(color: Colors.red),
                    //     )),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      keyboardType: TextInputType.name,
                      controller: usernameCont,
                      autoFocus: true,
                      nextFocus: passFocus,
                      decoration: inputDecoration(
                          labelText: 'Username',
                          icon: const Icon(Icons.person)),
                    ),
                    16.height,
                    AppTextField(
                      controller: name,
                      textFieldType: TextFieldType.NAME,
                      keyboardType: TextInputType.name,
                      decoration: inputDecoration(
                          labelText: 'Name', icon: const Icon(Icons.person_pin_rounded)),
                    ),
                    16.height,
                    AppTextField(
                      controller: emailCont,
                      textFieldType: TextFieldType.EMAIL,
                      keyboardType: TextInputType.emailAddress,
                      nextFocus: conformPassFocus,
                      decoration: inputDecoration(
                          labelText: 'Email', icon: const Icon(Icons.mail)),
                    ),
                    16.height,
                    AppTextField(
                      controller: phone,
                      textFieldType: TextFieldType.PHONE,
                      keyboardType: TextInputType.phone,
                      decoration: inputDecoration(
                          labelText: 'Phone', icon: const Icon(Icons.phone)),
                    ),
                    16.height,
                    AppTextField(
                      controller: passCont,
                      textFieldType: TextFieldType.PASSWORD,
                      focus: passFocus,
                      decoration: inputDecoration(
                          labelText: 'Password', icon: const Icon(Icons.lock)),
                      onFieldSubmitted: (p0) {
                        submit();
                      },
                    ),
                    16.height,
                    AppTextField(
                      controller: confirmPassCont,
                      textFieldType: TextFieldType.PASSWORD,
                      focus: conformPassFocus,
                      validator: (String? value) {
                        if (value!.isEmpty) return errorThisFieldRequired;
                        if (value.length < passwordLengthGlobal) {
                          return 'Password length should be more than six';
                        }
                        if (value.trim() != passCont.text.trim()) {
                          return 'Both password should be matched';
                        }

                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (s) {
                        submit();
                      },
                      decoration: inputDecoration(
                          labelText: 'Confirm Password',
                          icon: const Icon(Icons.lock)),
                    ),
                    18.height,
                    AppButton(
                      width: context.width(),
                      text: 'Sign Up',
                      onTap: () {
                        submit();
                      },
                      shapeBorder:
                      RoundedRectangleBorder(borderRadius: radius(16)),
                    ),
                    8.height,
                  ],
                ),
              ).center(),
              8.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: secondaryTextStyle(size: 14)),
                  8.width,
                  TextButton(
                    child: Text('Sign In Here', style: boldTextStyle()),
                    onPressed: () {
                      finish(context);
                    },
                  )
                ],
              ),
            ]// const FooterOur(),
          ).center()
      )
    )
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
