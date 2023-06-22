import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';
import 'package:uuid/uuid.dart';

class PurchaseCard extends StatefulWidget {
  const PurchaseCard({
    Key? key,
  }) : super(key: key);

  @override
  _PurchaseCardState createState() => _PurchaseCardState();
}

class _PurchaseCardState extends State<PurchaseCard> {
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Mastercard Price 3000",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
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
                                      color: kPrimaryClr.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10)),
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
                                          const Text("Account Name"),
                                          20.width,
                                          const Expanded(
                                            child: MarkdownBody(
                                              softLineBreak: true,
                                              selectable: true,
                                              data: "Muhammad Ahmed",
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
                                      color: kPrimaryClr.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10)),
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
                                          const Text("Account Name"),
                                          20.width,
                                          const Expanded(
                                            child: MarkdownBody(
                                              softLineBreak: true,
                                              selectable: true,
                                              data: 'Muhammad Ahmed',
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
                                  left: 100.0,
                                  right: 100.0,
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
    CollectionReference banner = FirebaseFirestore.instance.collection('users');

    return banner
        .doc(box.read('uid'))
        .update({
          'invoice': value,
          'active': true,
          'packageprice': 3000,
          'rankpoints': 20,
          'buy': true,
        })
        .whenComplete(() => EasyLoading.dismiss())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"))
        .whenComplete(() => EasyLoading.dismiss());
  }
}
