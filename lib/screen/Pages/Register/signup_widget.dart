// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:mlm_website/utilities/constants.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   var emailTextController = TextEditingController();
//   var passwordTextController = TextEditingController();
//   var confirmpasswordTextController = TextEditingController();
//   var firstName = TextEditingController();
//   var lastName = TextEditingController();
//   bool isvisible = true;
//   bool confirmisvisible = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kWhiteClr,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 const Text(
//                   "Sign Up",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(left: 15.0),
//                   decoration: BoxDecoration(
//                     color: kSecondarClr,
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: TextFormField(
//                     controller: emailTextController,
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter Email";
//                       }
//                       //now we use email validator package
//                       final bool _isvalid =
//                           EmailValidator.validate(emailTextController.text);
//                       if (!_isvalid) {
//                         return "Email was entered incorrectly";
//                       }
//                       return null;
//                     },
//                     decoration: const InputDecoration(
//                       suffixIcon: Icon(Icons.email_outlined),
//                       hintText: "Email",
//                       enabledBorder: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(left: 15.0),
//                   decoration: BoxDecoration(
//                     color: kSecondarClr,
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: TextFormField(
//                     controller: firstName,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter First Name";
//                       }

//                       return null;
//                     },
//                     decoration: const InputDecoration(
//                       suffixIcon: Icon(Icons.person_outline),
//                       hintText: "First Name",
//                       enabledBorder: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(left: 15.0),
//                   decoration: BoxDecoration(
//                     color: kSecondarClr,
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: TextFormField(
//                     controller: lastName,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter Last Name";
//                       }

//                       return null;
//                     },
//                     decoration: const InputDecoration(
//                       suffixIcon: Icon(Icons.person_outline),
//                       hintText: "Last Name",
//                       enabledBorder: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 //password field
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(left: 15.0),
//                   decoration: BoxDecoration(
//                     color: kSecondarClr,
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: TextFormField(
//                     obscureText: isvisible,
//                     controller: passwordTextController,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter Password";
//                       }

//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                         onPressed: () {
//                           setState(() {
//                             isvisible = !isvisible;
//                           });
//                         },
//                         icon: isvisible == true
//                             ? Icon(Icons.visibility)
//                             : Icon(Icons.visibility_off),
//                         color: isvisible == true ? kSecondarClr : kPrimaryClr,
//                       ),
//                       hintText: "Password",
//                       enabledBorder: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 //confirm password field
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(left: 15.0),
//                   decoration: BoxDecoration(
//                     color: kSecondarClr,
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: TextFormField(
//                     obscureText: confirmisvisible,
//                     controller: confirmpasswordTextController,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter Password";
//                       }
//                       if (passwordTextController.text !=
//                           confirmpasswordTextController.text) {
//                         return "Password not Matched";
//                       }

//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                         onPressed: () {
//                           setState(() {
//                             confirmisvisible = !confirmisvisible;
//                           });
//                         },
//                         icon: confirmisvisible == true
//                             ? Icon(Icons.visibility)
//                             : Icon(Icons.visibility_off),
//                         color: confirmisvisible == true
//                             ? kSecondarClr
//                             : kPrimaryClr,
//                       ),
//                       hintText: "Re-Enter Password",
//                       enabledBorder: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [],
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 //sign Up Button
//                 MaterialButton(
//                   color: kPrimaryClr,
//                   minWidth: double.infinity,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   height: 50,
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {}
//                   },
//                   child: const Text(
//                     "Sign Up",
//                     style: TextStyle(
//                       color: kPrimaryClr,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 // SocialLoginBtn(),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Already a member ?",
//                       style: TextStyle(
//                         color: kSecondarClr,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     InkWell(
//                       onTap: () {},
//                       child: const Text(
//                         "Log in",
//                         style: TextStyle(
//                             color: kPrimaryClr, fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
