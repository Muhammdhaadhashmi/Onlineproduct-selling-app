import 'dart:io';
import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';
import 'package:oktoast/oktoast.dart';
import 'package:uuid/uuid.dart';

import 'components/side_menu.dart';

class BannerSection extends StatefulWidget {
  const BannerSection({Key? key}) : super(key: key);

  @override
  _BannerSectionState createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  List<Widget> itemPhotosWidgetList = <Widget>[];
  CollectionReference delban = FirebaseFirestore.instance.collection('banner');
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('banner').snapshots();
  final ImagePicker _picker = ImagePicker();
  File? file;
  List<XFile>? photo = <XFile>[];
  List<XFile> itemImagesList = <XFile>[];

  List<String> downloadUrl = <String>[];

  bool uploading = false;
  Future<void> deleteUser(name) {
    return delban
        .doc(name)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return OKToast(
        child: Scaffold(
      drawer: Drawer(
        child: DraweAdmin(),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: _size.width >= 702 ? false : true,
        iconTheme: const IconThemeData(color: kWhiteClr),
        title: const Text(
          appName,
          style: TextStyle(color: kWhiteClr),
        ),
      ),
      body: Row(
        children: [
          _size.width >= 702 ? const SideMenu() : Container(),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  32.height,
                  const Text(
                    "Products",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  32.height,
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
                            onPressed: uploading ? null : () => upload(),
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
                  StreamBuilder<QuerySnapshot>(
                    stream: _usersStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading");
                      }

                      return Container(
                        color: kPrimaryClr.withOpacity(0.1),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          data['image'],
                                          height: 220,
                                          width: 300,
                                          fit: BoxFit.cover,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                deleteUser(document.id);
                                              });
                                            },
                                            icon: const Icon(Icons.delete)),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  20.height,
                ],
              ),
            ),
          ),
        ],
      ),
    ));
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
        FirebaseFirestore.instance.collection('banner');

    return banner
        .add({
          'image': value,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
