import 'package:flutter/material.dart';
import 'package:onicame/screen/Pages/contactus/contact_us.dart';
import 'package:onicame/screen/Pages/term&privacy/privacypolicy.dart';
import 'package:onicame/screen/Pages/term&privacy/term&conditionpage.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

class FooterOur extends StatelessWidget {
  const FooterOur({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: kPrimaryClr.withOpacity(0.1)),
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: kMaxWidth,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Wrap(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            appName,
                            style: TextStyle(
                              fontSize: _size.width >= 450 ? 22 : 12,
                              color: kPrimaryClr,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        40.width,
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const PrivacyPolicy();
                                });
                          },
                          child: Text(
                            "Privacy",
                            style: TextStyle(
                                fontSize: _size.width >= 450 ? 16 : 12),
                          ),
                        ),
                        10.width,
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const TermConditionPage();
                                });
                          },
                          child: Text(
                            "Term & Conditions",
                            style: TextStyle(
                                fontSize: _size.width >= 450 ? 16 : 12),
                          ),
                        ),
                        10.width,
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const Contactus();
                                });
                          },
                          child: Text(
                            "Contact Us",
                            style: TextStyle(
                                fontSize: _size.width >= 450 ? 16 : 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
