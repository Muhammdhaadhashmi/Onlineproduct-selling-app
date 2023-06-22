import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:onicame/admin/admin_dashboard.dart';
import 'package:onicame/main.dart';
import 'package:onicame/screen/Pages/Register/registraion_page.dart';
import 'package:onicame/screen/Pages/footer/our_footer.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:onicame/utils/widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'components/side_menu.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
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
          .collection('admin')
          .where('username', isEqualTo: emailCont.text)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc['username'] == emailCont.text &&
              doc['password'] == passCont.text) {
            setState(() {
              bool shownot1 = true;
            });

            box
                .write('adminlogin', true)
                .whenComplete(() => context.goNamed('/admin'));

            print('ok');
            EasyLoading.dismiss();
          } else {
            setState(() {
              bool shownot1 = true;
            });
            EasyLoading.showError("Wrong Password");
          }
        });
      });
      FirebaseFirestore.instance
          .collection('admin')
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

      ;

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

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: DraweAdmin(),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: _size.width >= 702 ? false : true,
        iconTheme: IconThemeData(color: kWhiteClr),
        title: Text(
          appName,
          style: TextStyle(color: kWhiteClr),
        ),
      ),
      body: box.read("adminlogin") == true
          ? AdminDashboard()
          : Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PageLabel(label: "Admin"),
                    Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(16),
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
                                labelText: 'Email', icon: Icon(Icons.person)),
                          ),
                          16.height,
                          AppTextField(
                            controller: passCont,
                            textFieldType: TextFieldType.PASSWORD,
                            focus: passFocus,
                            decoration: inputDecoration(
                                labelText: 'Password', icon: Icon(Icons.lock)),
                            onFieldSubmitted: (p0) {
                              submit();
                            },
                          ),
                          16.height,
                          AppButton(
                            width: double.infinity,
                            text: 'Sign In',
                            shapeBorder: RoundedRectangleBorder(
                                borderRadius: radius(16)),
                            onTap: () {
                              submit();
                            },
                          ),
                          8.height,
                        ],
                      ),
                    ).center(),
                    16.height,

                    const SizedBox(
                      height: 50,
                    ),
                    //footor
                    FooterOur(),
                  ],
                ),
              ),
            ),
    );
  }
}


// AdminDashboard()