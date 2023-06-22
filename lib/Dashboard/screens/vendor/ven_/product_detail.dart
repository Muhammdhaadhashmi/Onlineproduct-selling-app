import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onicame/admin/active_buyer.dart';
import 'package:onicame/component/label.dart';
import 'package:onicame/utils/colors.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

class VendorProductDetail extends StatefulWidget {
  final DocumentSnapshot data;
  final String id;
  const VendorProductDetail({Key? key, required this.data, required this.id})
      : super(key: key);

  @override
  _VendorProductDetailState createState() => _VendorProductDetailState();
}

class _VendorProductDetailState extends State<VendorProductDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageLabel(label: widget.data['productname']),
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
                      // Styling(title: 'Name', disc: widget.data['username']),
                      20.height,

                      Styling(
                          title: 'Package Name',
                          disc: widget.data['productname']),
                      20.height,
                      Styling(
                          title: 'Package Price',
                          disc:
                              "${widget.data['packageprice'] - widget.data['packagedelivery']}"),
                      20.height,
                      Styling(
                          title: 'Delivery Charges',
                          disc: "${widget.data['packagedelivery']}"),
                      20.height,

                      FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.data['customerid'])
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Something went wrong");
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return const Text("Document does not exist");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Column(
                              children: [
                                Styling(
                                    title: 'Cutomer Name',
                                    disc:
                                        "${data['firstName']} ${data['lastname']}"),
                                20.height,
                                Styling(
                                    title: 'Cutomer Address',
                                    disc: "${data['address']}"),
                                20.height,
                                Styling(
                                    title: 'Cutomer Phone',
                                    disc: "${data['mobileno']}"),
                                20.height,
                              ],
                            );
                          }

                          return const Text("loading");
                        },
                      ),

                      10.height,
                      Image.network(
                        widget.data['image'],
                        height: MediaQuery.of(context).size.height * 0.6,
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
