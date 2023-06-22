import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:onicame/Dashboard/screens/Earning/eraning_screen.dart';
import 'package:onicame/Dashboard/screens/Ranks/ranks.dart';
import 'package:onicame/Dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:onicame/Dashboard/screens/genology/genology.dart';
import 'package:onicame/Dashboard/screens/support/components/edit.dart';
import 'package:onicame/Dashboard/screens/support/support.dart';
import 'package:onicame/Dashboard/screens/withdraw/withdrawscreen.dart';

import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:share_plus/share_plus.dart';

class UserSideMenu extends StatelessWidget {
  const UserSideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(flex: 2, child: UserDraweAdmin());
  }
}

class UserDraweAdmin extends StatefulWidget {
  const UserDraweAdmin({
    Key? key,
  }) : super(key: key);

  @override
  State<UserDraweAdmin> createState() => _UserDraweAdminState();
}

class _UserDraweAdminState extends State<UserDraweAdmin> {
  userLogout() {
    box.erase();

    (context).goNamed("home");
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (box.read("login") != true) {
        (context).goNamed("home");
      }
    });
    return Container(
      color: kPrimaryClr,
      child: ListView(
        children: [
          SideButton(
            icon: Icons.dashboard,
            press: () {
              (context).goNamed('dashboard');
            },
            title: "Dashboard",
          ),
          SideButton(
            icon: Icons.dashboard,
            press: () {
              (context).goNamed('home');
            },
            title: "Go Back Home Screen",
          ),
          SideButton(
            icon: Icons.dashboard,
            press: () {
              (context).goNamed('vendor');
            },
            title: "Vender",
          ),
          SideButton(
            icon: Icons.group,
            press: () {
              (context).goNamed('genology');
            },
            title: "Genealogy",
          ),
          SideButton(
            icon: Icons.card_giftcard,
            press: () {
              (context).goNamed('earning');
            },
            title: "My Earning",
          ),
          SideButton(
            icon: Icons.map_rounded,
            press: () {
              (context).goNamed('withdraw');
            },
            title: "Withdraw",
          ),
          SideButton(
            icon: Icons.credit_card,
            press: () {
              (context).goNamed('my-master-card');
            },
            title: "Master Card",
          ),
          SideButton(
            icon: Icons.map_rounded,
            press: () {
              (context).goNamed('withdraw-history');
            },
            title: "Withdraw History",
          ),
          SideButton(
            icon: Icons.map_outlined,
            press: () {
              (context).goNamed('ranks');
            },
            title: "Ranks",
          ),
          SideButton(
            icon: Icons.person,
            press: () {
              (context).goNamed('account');
            },
            title: "Account",
          ),
          SideButton(
            icon: Icons.person,
            press: () {
              (context).goNamed('edit-account');
            },
            title: "Edit Account",
          ),
          SideButton(
            icon: Icons.room_preferences,
            press: () async {
              await Share.share(
                  "https://onicame.com/registration/reflink/${box.read('uid')}");
            },
            title: "Share Reference",
          ),
          SideButton(
            icon: Icons.logout,
            press: () {
              userLogout();
            },
            title: "Logout",
          ),
        ],
      ),
    );
  }
}

class UserDraweuser extends StatefulWidget {
  const UserDraweuser({
    Key? key,
  }) : super(key: key);

  @override
  State<UserDraweuser> createState() => _UserDraweuserState();
}

class _UserDraweuserState extends State<UserDraweuser> {
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
              icon: Icons.dashboard,
              press: () {
                Get.to(const Dashboard());
              },
              title: "Dashboard",
            ),
            SideButton(
              icon: Icons.group,
              press: () {
                Get.to(const GenologyScreen());
              },
              title: "Genealogy",
            ),
            SideButton(
              icon: Icons.card_giftcard,
              press: () {
                Get.to(const EarningScreen());
              },
              title: "My Earning",
            ),
            SideButton(
              icon: Icons.map_rounded,
              press: () {
                Get.to(const WithDrawScreen());
              },
              title: "Withdraw",
            ),
            SideButton(
              icon: Icons.map_outlined,
              press: () {
                Get.to(const RankScreen());
              },
              title: "Ranks",
            ),
            SideButton(
              icon: Icons.person,
              press: () {
                Get.to(const supportScreen());
              },
              title: "Account",
            ),
            SideButton(
              icon: Icons.person,
              press: () {
                Get.to(const EditsupportScreen());
              },
              title: "Edit Account",
            ),
            SideButton(
              icon: Icons.logout,
              press: () {
                userLogout();
              },
              title: "Logout",
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
        color: kWhiteClr,
      ),
      title: Text(
        title,
        style: const TextStyle(color: kWhiteClr),
      ),
    );
  }
}
