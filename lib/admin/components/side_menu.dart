import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (box.read("adminlogin") != true) {
        (context).goNamed("home");
      }
    });
    return Expanded(flex: 2, child: DraweAdmin());
  }
}

class DraweAdmin extends StatelessWidget {
  DraweAdmin({
    Key? key,
  }) : super(key: key);
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryClr,
      child: ListView(
        children: [
          SideButton(
            icon: Icons.dashboard,
            press: () {
              context.goNamed('admin');
            },
            title: "Dashboard",
          ),
          const Divider(
            thickness: 2,
            color: kWhiteClr,
          ),
          SideButton(
            icon: Icons.dashboard,
            press: () {
              context.goNamed('banner');
            },
            title: "Banner",
          ),
          const Divider(
            thickness: 2,
            color: kWhiteClr,
          ),
          SideButton(
            icon: Icons.dashboard,
            press: () {
              context.goNamed('our-balance');
            },
            title: "Our Balance",
          ),
          const Divider(
            thickness: 2,
            color: kWhiteClr,
          ),
          SideButton(
            icon: Icons.dashboard,
            press: () {
              context.goNamed('withdrawn-approve');
            },
            title: "Withdraw User",
          ),
          const Divider(
            thickness: 2,
            color: kWhiteClr,
          ),
          SideButton(
            icon: Icons.dashboard,
            press: () {
              context.goNamed('admin_withdraw');
            },
            title: "Withdraw History",
          ),
          const Divider(
            thickness: 2,
            color: kWhiteClr,
          ),
          SideButton(
            icon: Icons.dashboard,
            press: () {
              context.goNamed('add-new-product');
            },
            title: "Product",
          ),
          const Divider(
            thickness: 2,
            color: kWhiteClr,
          ),
          SideButton(
            icon: Icons.dashboard,
            press: () {
              context.goNamed('cartlist');
            },
            title: "Card List",
          ),
          const Divider(
            thickness: 2,
            color: kWhiteClr,
          ),
          SideButton(
            icon: Icons.dashboard,
            press: () {
              context.goNamed('active-buyer');
            },
            title: "Active Buyer",
          ),
          const Divider(
            thickness: 2,
            color: kWhiteClr,
          ),
          SideButton(
            icon: Icons.dashboard,
            press: () {
              context.goNamed('create-about');
            },
            title: "About",
          ),
          const Divider(
            thickness: 2,
            color: kWhiteClr,
          ),
          SideButton(
            icon: Icons.dashboard,
            press: () {
              context.goNamed('create-privacy');
            },
            title: "Privacy",
          ),
          const Divider(
            thickness: 2,
            color: kWhiteClr,
          ),
          SideButton(
            icon: Icons.dashboard,
            press: () {
              context.goNamed('term-conditions');
            },
            title: "Term & Conditions",
          ),
          const Divider(
            thickness: 2,
            color: kWhiteClr,
          ),
          SideButton(
            icon: Icons.logout,
            press: () {
              box.remove("adminlogin");
              context.goNamed('home');
            },
            title: "Logout",
          ),
        ],
      ),
    );
  }
}

class Draweuser extends StatefulWidget {
  const Draweuser({
    Key? key,
  }) : super(key: key);

  @override
  State<Draweuser> createState() => _DraweuserState();
}

class _DraweuserState extends State<Draweuser> {
  userLogout() {
    box.remove('uid');
    box.remove('email');
    box.remove('firstName');
    box.remove('login');
    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryClr,
      child: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                  child: Text(
                appName,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryClr),
              )),
            ),
            SideButton(
              icon: Icons.home_rounded,
              press: () {
                context.goNamed('home');
              },
              title: "Home",
            ),
            SideButton(
              icon: Icons.all_inbox_outlined,
              press: () {
                context.goNamed('about-us');
              },
              title: "About Us",
            ),
            SideButton(
              icon: Icons.account_box_outlined,
              press: () {
                context.goNamed('registration');
              },
              title: "Registration",
            ),
            SideButton(
              icon: Icons.account_box_outlined,
              press: () {
                context.goNamed('products');
              },
              title: "Product",
            ),
            box.read("login") == true
                ? Column(
                    children: [
                      SideButton(
                        icon: Icons.dashboard,
                        press: () {
                          context.goNamed('dashboard');
                        },
                        title: "Dashboard",
                      ),
                      SideButton(
                        icon: Icons.logout,
                        press: () {
                          // authService.logout(context);
                          userLogout();
                        },
                        title: "Logout",
                      ),
                    ],
                  )
                : SideButton(
                    icon: Icons.login,
                    press: () {
                      context.goNamed('login');
                    },
                    title: "Login",
                  ),
          ],
        ),
      ),
    );
  }
}

class SideButton extends StatelessWidget {
  final String title;
  final VoidCallback press;
  final IconData icon;
  const SideButton({
    Key? key,
    required this.title,
    required this.press,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: Icon(
        icon,
        color: kwhiteClr,
      ),
      title: Text(
        title,
        style: const TextStyle(color: kBlackClr),
      ),
    );
  }
}
