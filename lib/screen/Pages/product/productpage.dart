import 'dart:io';
import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:onicame/admin/components/side_menu.dart';
import 'package:onicame/component/label.dart';
import 'package:onicame/main.dart';
import 'package:onicame/screen/Pages/footer/our_footer.dart';
import 'package:onicame/screen/Pages/modules/widgets/navigation_bar.dart';
import 'package:onicame/screen/Pages/product/user_product_detail.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/enums.dart';
import 'package:uuid/uuid.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('products')
      .orderBy('time', descending: false)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: const Drawer(
          child: Draweuser(),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: _size.width >= 786 ? false : true,
          elevation: 1,
          backgroundColor: kWhiteClr,
          title: const NavContainer(
            select: MenuState.product,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                const PageLabel(
                  label: "Products",
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: kMaxWidth,
                  ),
                  child: ProductCardContainer(usersStream: _usersStream),
                ),
                const SizedBox(
                  height: 50,
                ),
                //footor
                const FooterOur(),
              ],
            ),
          ),
        ])));
  }
}

class ProductCardContainer extends StatelessWidget {
  const ProductCardContainer({
    Key? key,
    required Stream<QuerySnapshot<Object?>> usersStream,
  })  : _usersStream = usersStream,
        super(key: key);

  final Stream<QuerySnapshot<Object?>> _usersStream;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //packages

        StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                return ProductCards(
                  data: data,
                  id: document.id,
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class ProductCards extends StatelessWidget {
  const ProductCards({
    Key? key,
    required this.data,
    required this.id,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final String id;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                  onTap: () {
                    User? user = FirebaseAuth.instance.currentUser;
                    if (box.read("login") == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProductDetail(
                                    data: data,
                                    id: id,
                                  )));
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
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['packagename'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    10.height,
                                    Text(
                                      "Rs. ${data['productprice']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                  )))
        ]));
  }
}

class Userproductdetail extends StatefulWidget {
  final String vendorid;
  final String pkgid;
  final int packageprice;
  final String packagename, packageimage, prodcutdiscription;
  const Userproductdetail({
    Key? key,
    required this.vendorid,
    required this.packageprice,
    required this.packagename,
    required this.packageimage,
    required this.pkgid,
    required this.prodcutdiscription,
  }) : super(key: key);

  @override
  _UserproductdetailState createState() => _UserproductdetailState();
}

class _UserproductdetailState extends State<Userproductdetail> {
  CollectionReference product =
      FirebaseFirestore.instance.collection('products');
  List<Widget> itemPhotosWidgetList = <Widget>[];

  final ImagePicker _picker = ImagePicker();
  File? file;
  List<XFile>? photo = <XFile>[];
  List<XFile> itemImagesList = <XFile>[];

  List<String> downloadUrl = <String>[];

  bool uploading = false;
  String package = '';
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Dialog(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: OKToast(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder<DocumentSnapshot>(
                      future: product.doc(widget.pkgid).get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return const Text("Document does not exist");
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;

                          return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(children: [
                                Text(
                                  "Product Name: ${data['packagename']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                20.height,
                                Text(
                                  "Product Price: ${data['productprice']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                40.height,
                                Column(
                                  children: [
                                    Wrap(
                                      spacing: 10.0,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              width: 200,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: kPrimaryClr
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "images/assets/easy.png",
                                                    height: 150,
                                                    width: 150,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  20.height,
                                                  Row(
                                                    children: [
                                                      const Text(
                                                          "Account Name"),
                                                      20.width,
                                                      const Expanded(
                                                        child: MarkdownBody(
                                                          softLineBreak: true,
                                                          selectable: true,
                                                          data:
                                                              "Muhammad Ahmed",
                                                          shrinkWrap: true,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  20.height,
                                                  Row(
                                                    children: [
                                                      const Text("Account No."),
                                                      20.width,
                                                      const Expanded(
                                                        child: MarkdownBody(
                                                          softLineBreak: true,
                                                          selectable: true,
                                                          data: '03033287958',
                                                          shrinkWrap: true,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              width: 200,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: kPrimaryClr
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "images/assets/jazzcash.png",
                                                    height: 150,
                                                    width: 150,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  20.height,
                                                  Row(
                                                    children: [
                                                      const Text(
                                                          "Account Name"),
                                                      20.width,
                                                      const Expanded(
                                                        child: MarkdownBody(
                                                          softLineBreak: true,
                                                          selectable: true,
                                                          data:
                                                              'Muhammad Ahmed',
                                                          shrinkWrap: true,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  20.height,
                                                  Row(
                                                    children: [
                                                      const Text("Account No."),
                                                      20.width,
                                                      const Expanded(
                                                        child: MarkdownBody(
                                                          softLineBreak: true,
                                                          selectable: true,
                                                          data: '03033287958',
                                                          shrinkWrap: true,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(8.0),
                                        //   child: Container(
                                        //       width: 200,
                                        //       padding: const EdgeInsets.all(5),
                                        //       decoration: BoxDecoration(
                                        //           color: kPrimaryClr
                                        //               .withOpacity(0.2),
                                        //           borderRadius:
                                        //               BorderRadius.circular(
                                        //                   10)),
                                        //       child: Column(
                                        //         children: [
                                        //           Image.asset(
                                        //             "images/assets/bank.png",
                                        //             height: 150,
                                        //             width: 150,
                                        //             fit: BoxFit.cover,
                                        //           ),
                                        //           10.height,
                                        //           Row(
                                        //             children: [
                                        //               const Text("Bank Name"),
                                        //               20.width,
                                        //               MarkdownBody(
                                        //                 softLineBreak: true,
                                        //                 selectable: true,
                                        //                 data: data['bankname'],
                                        //                 shrinkWrap: true,
                                        //               ),
                                        //             ],
                                        //           ),
                                        //           20.height,
                                        //           Row(
                                        //             children: [
                                        //               const Text(
                                        //                   "Account Name"),
                                        //               20.width,
                                        //               Expanded(
                                        //                 child: MarkdownBody(
                                        //                   softLineBreak: true,
                                        //                   selectable: true,
                                        //                   data:
                                        //                       data['easyuser'],
                                        //                   shrinkWrap: true,
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //           20.height,
                                        //           Row(
                                        //             children: [
                                        //               const Text("Account No."),
                                        //               20.width,
                                        //               Expanded(
                                        //                 child: MarkdownBody(
                                        //                   softLineBreak: true,
                                        //                   selectable: true,
                                        //                   data: data['bank'],
                                        //                   shrinkWrap: true,
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ],
                                        //       )),
                                        // )
                                      ],
                                    )
                                  ],
                                )
                              ]));
                        }

                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(12.0),
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white70,
                                ),
                                width: _size.width * 0.7,
                                height: 300.0,
                                child: Center(
                                  child: itemPhotosWidgetList.isEmpty
                                      ? Center(
                                          child: MaterialButton(
                                            onPressed: pickPhotoFromGallery,
                                            child: Container(
                                              alignment: Alignment.bottomCenter,
                                              child: Center(
                                                child: Image.network(
                                                  "https://static.thenounproject.com/png/3322766-200.png",
                                                  height: 100.0,
                                                  width: 100.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : FittedBox(
                                          child: Row(
                                            children: itemPhotosWidgetList,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 50.0,
                                ),
                                child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 15.0),
                                    color: kPrimaryClr,
                                    onPressed: () {
                                      if (itemPhotosWidgetList.isNotEmpty) {
                                        EasyLoading.show();
                                        upload();
                                      }
                                    },
                                    child: uploading
                                        ? const SizedBox(
                                            child: CircularProgressIndicator(),
                                            height: 15.0,
                                          )
                                        : const Text(
                                            "Add",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                              ),
                            ],
                          ),
                          20.height,
                          20.height,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  addImage() {
    for (var bytes in photo!) {
      itemPhotosWidgetList.add(Padding(
        padding: const EdgeInsets.all(1.0),
        child: SizedBox(
          height: 90.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              child: kIsWeb
                  ? Image.network(File(bytes.path).path)
                  : Image.file(
                      File(bytes.path),
                    ),
            ),
          ),
        ),
      ));
    }
  }

  pickPhotoFromGallery() async {
    photo = await _picker.pickMultiImage();
    if (photo != null) {
      setState(() {
        itemImagesList = itemImagesList + photo!;
        addImage();
        photo!.clear();
      });
    }
  }

  upload() async {
    String productId = await uplaodImageAndSaveItemInfo();
    setState(() {
      uploading = false;
    });
    showToast("Image Uploaded Successfully");
  }

  Future<String> uplaodImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });
    PickedFile? pickedFile;
    String? productId = const Uuid().v4();
    for (int i = 0; i < itemImagesList.length; i++) {
      file = File(itemImagesList[i].path);
      pickedFile = PickedFile(file!.path);

      await uploadImageToStorage(pickedFile, productId);
    }
    return productId;
  }

  uploadImageToStorage(PickedFile? pickedFile, String productId) async {
    String? pId = const Uuid().v4();
    Reference reference =
        FirebaseStorage.instance.ref().child('Items/$productId/product_$pId');
    await reference.putData(
      await pickedFile!.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );
    String value = await reference.getDownloadURL();
    downloadUrl.add(value);
    CollectionReference banner =
        FirebaseFirestore.instance.collection('buyproducts');

    return banner
        .add({
          'invoice': value,
          'productimage': widget.packageimage,
          'vendorid': widget.vendorid,
          'packagename': widget.packagename,
          'packageprice': widget.packageprice,
          'customerid': box.read('uid'),
          'prodcutdiscription': widget.prodcutdiscription,
          'active': false,
        })
        .whenComplete(() => EasyLoading.dismiss())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"))
        .whenComplete(() => EasyLoading.dismiss());
  }
}
