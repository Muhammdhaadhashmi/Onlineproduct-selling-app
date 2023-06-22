import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:onicame/utils/enums.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:go_router/go_router.dart';
import 'navigation_item.dart';

class NavContainer extends StatefulWidget {
  final MenuState select;
  const NavContainer({Key? key, required this.select}) : super(key: key);

  @override
  State<NavContainer> createState() => _NavContainerState();
}

class _NavContainerState extends State<NavContainer> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                  constraints: const BoxConstraints(maxWidth: kMaxWidth),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              context.goNamed('home');
                            },
                            child: Text(
                              appName,
                              style: TextStyle(
                                fontSize: _size.width >= 400 ? 22 : 16,
                                color: kPrimaryClr,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          _size.width >= 786
                              ? Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: MenuState.home ==
                                                            widget.select
                                                        ? kPrimaryClr
                                                        : kWhiteClr,
                                                    width: 3))),
                                        child: NavigationItem(
                                          title: 'Home',
                                          press: () {
                                            (context).goNamed('home');
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: MenuState.about ==
                                                            widget.select
                                                        ? kPrimaryClr
                                                        : kWhiteClr,
                                                    width: 3))),
                                        child: NavigationItem(
                                          title: 'About Us',
                                          press: () {
                                            (context).goNamed('about-us');
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: MenuState
                                                                  .registration ==
                                                              widget.select
                                                          ? kPrimaryClr
                                                          : kWhiteClr,
                                                      width: 3))),
                                          child: NavigationItem(
                                            title: 'Registration',
                                            press: () {
                                              (context).goNamed('registration');
                                            },
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          MenuState.product ==
                                                                  widget.select
                                                              ? kPrimaryClr
                                                              : kWhiteClr,
                                                      width: 3))),
                                          child: NavigationItem(
                                            title: 'Products',
                                            press: () {
                                              (context).goNamed('products');
                                            },
                                          ),
                                        )),
                                    box.read("login") == true
                                        ? Row(
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                color: MenuState
                                                                            .login ==
                                                                        widget
                                                                            .select
                                                                    ? kPrimaryClr
                                                                    : kWhiteClr,
                                                                width: 3))),
                                                    child: NavigationItem(
                                                      title: 'Dashboard',
                                                      press: () {
                                                        (context).goNamed(
                                                            'dashboard');
                                                      },
                                                    ),
                                                  )),
                                              Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                color: MenuState
                                                                            .login ==
                                                                        widget
                                                                            .select
                                                                    ? kPrimaryClr
                                                                    : kWhiteClr,
                                                                width: 3))),
                                                    child: NavigationItem(
                                                      title: 'Logout',
                                                      press: () {
                                                        setState(() {
                                                          box.erase();
                                                          (context)
                                                              .goNamed('home');
                                                        });
                                                      },
                                                    ),
                                                  )),
                                            ],
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: MenuState
                                                                      .login ==
                                                                  widget.select
                                                              ? kPrimaryClr
                                                              : kWhiteClr,
                                                          width: 3))),
                                              child: NavigationItem(
                                                title: 'Login',
                                                press: () {
                                                  (context).goNamed('login');
                                                },
                                              ),
                                            )),
                                  ],
                                )
                              : box.read("login") == true
                                  ? Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: MenuState
                                                                      .login ==
                                                                  widget.select
                                                              ? kPrimaryClr
                                                              : kWhiteClr,
                                                          width: 3))),
                                              child: NavigationItem(
                                                title: 'Dashboard',
                                                press: () {
                                                  (context)
                                                      .goNamed('dashboard');
                                                },
                                              ),
                                            )),
                                      ],
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: MenuState.login ==
                                                            widget.select
                                                        ? kPrimaryClr
                                                        : kWhiteClr,
                                                    width: 3))),
                                        child: NavigationItem(
                                          title: 'Login',
                                          press: () {
                                            (context).goNamed('login');
                                          },
                                        ),
                                      )),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class MobMenu extends StatefulWidget {
  const MobMenu({Key? key}) : super(key: key);

  @override
  _MobMenuState createState() => _MobMenuState();
}

class _MobMenuState extends State<MobMenu> {
  // int index = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          NavigationItem(
            title: 'Home',
            press: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          NavigationItem(
            title: 'About Us',
            press: () {
              Navigator.pushNamed(context, '/about-us');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          NavigationItem(
            title: 'Registration',
            press: () {
              Navigator.pushNamed(context, '/registration');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          NavigationItem(
            title: 'Products',
            press: () {
              Navigator.pushNamed(context, '/products');
            },
          ),
        ],
      ),
    );
  }
}

class MobFooterMenu extends StatefulWidget {
  const MobFooterMenu({Key? key}) : super(key: key);

  @override
  _MobFooterMenuState createState() => _MobFooterMenuState();
}

class _MobFooterMenuState extends State<MobFooterMenu> {
  // int index = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavigationItem(
                title: 'Home',
                press: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
              NavigationItem(
                title: 'About Us',
                press: () {
                  Navigator.pushNamed(context, '/about-us');
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavigationItem(
                title: 'Registration',
                press: () {
                  Navigator.pushNamed(context, '/registration');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              NavigationItem(
                title: 'Products',
                press: () {
                  Navigator.pushNamed(context, '/products');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Center(
            child: InkWell(
              onTap: () {
                (context).goNamed('home');
              },
              child: const Text(
                appName,
                style: TextStyle(
                  fontSize: 22,
                  color: kPrimaryClr,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),
          const MobMenu(),
        ],
      ),
    );
  }
}
