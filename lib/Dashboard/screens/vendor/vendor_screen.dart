import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onicame/Dashboard/components/usersidebar.dart';
import 'package:onicame/Dashboard/screens/vendor/add_product.dart';
import 'package:onicame/Dashboard/screens/vendor/deliveredorder.dart';
import 'package:onicame/Dashboard/screens/vendor/myordors.dart';
import 'package:onicame/Dashboard/screens/vendor/vendor_products.dart';
import 'package:onicame/utils/colors.dart';

import '../../../utils/constants.dart';

class VendorScreen extends StatefulWidget {
  static const String id = '/vendor';
  const VendorScreen({Key? key}) : super(key: key);

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  Future getUserAmount() async {}
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: const Drawer(
          child: UserDraweAdmin(),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: _size.width >= 702 ? false : true,
          iconTheme: const IconThemeData(color: kWhiteClr),
          title: const Text(
            appName,
            style: TextStyle(color: kWhiteClr),
          ),
        ),
        body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _size.width >= 702 ? const UserSideMenu() : Container(),
          Expanded(
              flex: 6,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  10.height,
                  Expanded(
                    child: DefaultTabController(
                      length: 4,
                      initialIndex: 0,
                      child: Column(
                        children: const [
                          TabBar(
                            labelColor: kprimaryClr,
                            isScrollable: true,
                            tabs: [
                              Tab(
                                text: "Add Product",
                              ),
                              Tab(
                                text: "My Product",
                              ),
                              Tab(
                                text: "My Orders",
                              ),
                              Tab(
                                text: "Delivered Orders",
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                AddvendorProduct(),
                                VendorProducts(),
                                VendorOrders(),
                                VendorDeliveredOrders(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ))
        ]));
  }
}
