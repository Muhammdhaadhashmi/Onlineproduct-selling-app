import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onicame/Dashboard/screens/vendor/ven_/product_detail.dart';
import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';

class VendorDeliveredOrders extends StatefulWidget {
  const VendorDeliveredOrders({Key? key}) : super(key: key);

  @override
  State<VendorDeliveredOrders> createState() => _VendorDeliveredOrdersState();
}

class _VendorDeliveredOrdersState extends State<VendorDeliveredOrders> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('vendororders')
      .where('vendorid', isEqualTo: box.read('uid'))
      .where('deliverd', isEqualTo: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Wrap(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VendorProductDetail(
                                data: document,
                                id: document.id,
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        child: Image.network(
                          data['image'],
                          height: 150,
                          width: 250,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          width: 250,
                          decoration: BoxDecoration(
                            color: kPrimaryClr.withOpacity(0.3),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data['productname'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: kSecondarClr,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Product Price",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "${data['packageprice'] - data['packagedelivery']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: kSecondarClr,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Delivery Charges",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "${data['packagedelivery']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
