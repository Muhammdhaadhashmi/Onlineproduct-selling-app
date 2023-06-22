import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onicame/component/forgot_password_component.dart';
import 'package:onicame/component/stacked_background.dart';
import 'package:onicame/screen/Pages/modules/widgets/navigation_bar.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/enums.dart';
import 'package:onicame/utils/widget.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  FocusNode userNameFocus = FocusNode();
  FocusNode passFocus = FocusNode();

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // Map<String, dynamic> data = {
      //   userKeys.email: emailCont.text,
      //   userKeys.password: passCont.text,
      // };

      // appStore.setIsLoading(true);
      // authService
      //     .signInWithEmailPassword(
      //         email: data[userKeys.email], password: data[userKeys.password])
      //     .then((value) {
      //   toasty(
      //     context,
      //     "Welcome Back ${box.read("firstName")}",
      //     borderRadius: radius(),
      //     bgColor: appButtonColor,
      //     textColor: primaryColor,
      //     gravity: ToastGravity.TOP,
      //   );
      //   push(Dashboard(),
      //       pageRouteAnimation: PageRouteAnimation.Fade, isNewTask: true);
      // }).catchError((e) {
      //   toast(e.toString());
      // }).whenComplete(() => appStore.setIsLoading(false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: kWhiteClr,
        title: const NavContainer(
          select: MenuState.login,
        ),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: StackedBackground(
          showBackButton: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: context.width() * 0.3,
                  decoration: boxDecorationDefault(),
                  child: Column(
                    children: [
                      16.height,
                      Text("Sign In", style: boldTextStyle(size: 22)),
                      32.height,
                      AppTextField(
                        textFieldType: TextFieldType.NAME,
                        keyboardType: TextInputType.name,
                        controller: emailCont,
                        autoFocus: true,
                        nextFocus: passFocus,
                        decoration: inputDecoration(
                            labelText: 'Email', icon: const Icon(Icons.person)),
                      ),
                      16.height,
                      AppTextField(
                        controller: passCont,
                        textFieldType: TextFieldType.PASSWORD,
                        focus: passFocus,
                        decoration: inputDecoration(
                            labelText: 'Password',
                            icon: const Icon(Icons.lock)),
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
                        width: context.width(),
                        text: 'Sign In',
                        shapeBorder:
                            RoundedRectangleBorder(borderRadius: radius(16)),
                        onTap: () {
                          submit();
                        },
                      ),
                      8.height,
                    ],
                  ),
                ).center(),
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: secondaryTextStyle(size: 14)),
                    8.width,
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "registration");
                      },
                      child:
                          Text('Create Account Here', style: boldTextStyle()),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
