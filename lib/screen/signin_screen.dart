import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:onicame/admin/components/side_menu.dart';
import 'package:onicame/component/forgot_password_component.dart';
import 'package:onicame/component/label.dart';
import 'package:onicame/main.dart';
import 'package:onicame/screen/Pages/modules/widgets/navigation_bar.dart';
import 'package:onicame/screen/signup_screen.dart';

import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/enums.dart';
import 'package:onicame/utils/widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'Pages/footer/our_footer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  FocusNode userNameFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  bool shownot = false;
  bool shownot1 = false;
  void submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      EasyLoading.show();
      FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: emailCont.text)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc['username'] == emailCont.text &&
              doc['password'] == passCont.text) {
            setState(() {
              bool shownot1 = true;
            });
            box.write('uid', doc['uid']);
            box.write('email', doc['email']);
            box.write('firstName', doc['username']);
            box.write('login', true);
            signinButton(doc['email'], passCont.text);

            print('ok');
          } else {
            setState(() {
              bool shownot1 = true;
            });
            EasyLoading.showError("Wrong Password");
          }
        }
      });
      FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: emailCont.text)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isEmpty) {
          EasyLoading.showError("No User Found");
        }
      });
      // .whenComplete(() {
      //   if (shownot1 == false) {
      //     EasyLoading.showError("No User Found");
      //   }
      // })

      // try {
      //   UserCredential userCredential = await FirebaseAuth.instance
      //       .signInWithEmailAndPassword(
      //           email: emailCont.text, password: passCont.text);
      //   FirebaseFirestore.instance
      //       .collection('users')
      //       .doc(userCredential.user!.uid)
      //       .get()
      //       .then((DocumentSnapshot documentSnapshot) {
      //     if (documentSnapshot.exists) {
      //       print('Document exists on the database');
      //       box.write('uid', documentSnapshot['uid']);
      //       box.write('email', documentSnapshot['email']);
      //       box.write('firstName', documentSnapshot['username']);
      //       box.write('login', true);

      //       Navigator.pushNamed(context, "/");
      //       EasyLoading.showSuccess("Login successfully");
      //     }
      //   });
      //   print('login');
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'user-not-found') {
      //     print('No user found for that email.');
      //     EasyLoading.showError('No user found for that email.');
      //   } else if (e.code == 'wrong-password') {
      //     print('Wrong password provided for that user.');
      //     EasyLoading.showError('Wrong password provided for that user.');
      //   }
      // }
    }
  }

  signinButton(String myemail, String mypass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: myemail, password: mypass);

      context.goNamed('home');
      EasyLoading.showSuccess("Login successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
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
              const PageLabel(label: "Login"),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(16),
                width: _size.width >= 550 ? 500 : double.infinity,
                decoration: boxDecorationDefault(),
                child: Column(
                  children: [
                    30.height,
                    32.height,
                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      keyboardType: TextInputType.name,
                      controller: emailCont,
                      autoFocus: true,
                      nextFocus: passFocus,
                      decoration: inputDecoration(
                          labelText: 'Username',
                          icon: const Icon(Icons.person)),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: Text('Forgot Password?',
                            style:
                                boldTextStyle(color: primaryColor, size: 12)),
                        onPressed: () {
                          showInDialog(
                            context,
                            builder: (_) => ForgotPasswordComponent(),
                            dialogAnimation: DialogAnimation.SLIDE_BOTTOM_TOP,
                          );
                        },
                      ),
                    ),
                    16.height,
                    AppButton(
                      width: double.infinity,
                      text: box.read("login") == true ? "Logout" : 'Login',
                      shapeBorder:
                          RoundedRectangleBorder(borderRadius: radius(16)),
                      onTap: () {
                        if (box.read("login") == true) {
                          // authService.logout(context);
                        } else {
                          submit();
                        }
                      },
                    ),
                    8.height,
                  ],
                ),
              ).center(),
              16.height,
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account?  ",
                    style: DefaultTextStyle.of(context).style,
                    children: const <TextSpan>[
                      TextSpan(
                          text: ' Create Account Here',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: kPrimaryClr)),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ),
              //footor
              const FooterOur(),
            ],
          ),
        ),
      ),
    );
  }
}
