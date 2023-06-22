import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onicame/admin/active_buyer.dart';
import 'package:onicame/component/label.dart';
import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

import '../Home/widgets/cate_screen.dart';

class UserProductDetail extends StatefulWidget {
  final Map<String, dynamic> data;
  final String id;
  const UserProductDetail({Key? key, required this.data, required this.id})
      : super(key: key);

  @override
  _UserProductDetailState createState() => _UserProductDetailState();
}

class _UserProductDetailState extends State<UserProductDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageLabel(label: widget.data['packagename']),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: kMaxWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Styling(title: 'Category', disc: widget.data['cate']),
                      10.height,
                      Container(
                        color: kprimaryClr,
                        child: Image.network(
                          widget.data['image'],
                          height: MediaQuery.of(context).size.height * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Styling(
                          title: 'Product Name',
                          disc: widget.data['packagename']),
                      20.height,
                      Styling(
                          title: 'Product Price',
                          disc: "${widget.data['productprice']}"),
                      20.height,
                      Styling(
                          title: 'Delivery Charges ',
                          disc: "${widget.data['prodcutdelivery']}"),
                      20.height,
                      Styling(title: 'Product Detail', disc: ""),
                      20.height,
                      Text(
                        widget.data['prodcutdiscription'],
                        style: TextStyle(fontSize: 16, height: 1.3),
                      ),
                      20.height,
                      Styling(
                          title: 'Total Price',
                          disc:
                              "${widget.data['productprice'] + widget.data['prodcutdelivery']}"),
                      20.height,
                      MaterialButton(
                        color: kPrimaryClr,
                        minWidth: double.infinity,
                        height: 45,
                        onPressed: () {
                          User? user = FirebaseAuth.instance.currentUser;
                          if (box.read("login") == true) {
                            print(widget.data['image']);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Userproductdetail(
                                    pkgid: widget.id,
                                    delivery: widget.data['prodcutdelivery'],
                                    prodcutdiscription:
                                        widget.data['prodcutdiscription'],
                                    packageimage: widget.data['image'],
                                    vendorid: widget.data['uid'],
                                    packageprice: widget.data['productprice'],
                                    packagename: widget.data['packagename'],
                                  );
                                });
                          } else {
                            toasty(
                              context,
                              "Please Login",
                              borderRadius: radius(),
                              bgColor: appButtonColor,
                              textColor: primaryColor,
                              gravity: ToastGravity.TOP,
                            );
                          }
                        },
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(color: kWhiteClr),
                        ),
                      ),
                      80.height,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Styling extends StatelessWidget {
  final String title, disc;
  const Styling({
    Key? key,
    required this.title,
    required this.disc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        30.width,
        Text(
          disc,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}
