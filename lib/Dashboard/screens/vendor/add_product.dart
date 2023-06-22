import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onicame/main.dart';
import 'package:onicame/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uuid/uuid.dart';

class AddvendorProduct extends StatefulWidget {
  const AddvendorProduct({Key? key}) : super(key: key);

  @override
  _AddvendorProductState createState() => _AddvendorProductState();
}

class _AddvendorProductState extends State<AddvendorProduct> {
  final _formKey = GlobalKey<FormState>();
  var productnameController = TextEditingController();
  var productaboutController = TextEditingController();
  var productdeliveryController = TextEditingController();
  var rankpointController = TextEditingController();
  var productpriceController = TextEditingController();
  var banknameController = TextEditingController();
  var bankuserController = TextEditingController();
  var bankController = TextEditingController();
  var jazzuserController = TextEditingController();
  var jazzController = TextEditingController();
  var easyuserController = TextEditingController();
  var easyController = TextEditingController();
  List<Widget> itemPhotosWidgetList = <Widget>[];
  CollectionReference product =
      FirebaseFirestore.instance.collection('products');
  bool uploading = false;
  final ImagePicker _picker = ImagePicker();
  File? file;
  List<XFile>? photo = <XFile>[];
  List<XFile> itemImagesList = <XFile>[];

  List<String> downloadUrl = <String>[];
  String _titlename = ' Select category';
  List<String> titlenameList = [
    'Cosmetics',
    'Clothes',
    'Bags',
    'Wallet',
    'Electronics',
    'Shoes',
    'Accessories',
    'Jewelry',
  ];
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

    addUser(value);
  }

  addUser(String value) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Call the user's CollectionReference to add a new user
      return product
          .add({
            'uid': box.read('uid'),
            'image': value,
            'packagename': productnameController.text,
            'productprice': int.parse(productpriceController.text),
            'prodcutdiscription': productaboutController.text,
            'prodcutdelivery': int.parse(productdeliveryController.text),
            'time': Timestamp.now(),
            'cate': _titlename,
          })
          .then((value) => EasyLoading.dismiss())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }

  Future<void> deleteUser(String name) {
    return product
        .doc(name)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(20),
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: fieldDecration(
                                hint: _titlename,
                                icon: DropdownButton(
                                  isExpanded: true,
                                  hint: Text(_titlename),
                                  focusColor: kPrimaryClr,
                                  underline: Container(
                                    height: 0,
                                    color: Colors.transparent,
                                  ),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _titlename = newValue!;
                                    });
                                  },
                                  items: titlenameList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            value.toString(),
                                            style: const TextStyle(
                                                color: kPrimaryClr),
                                          ),
                                        ));
                                  }).toList(),
                                ),
                                title: ""),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: productnameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Product Name";
                              }
                              return null;
                            },
                            decoration: fieldDecration(
                                hint: "Enter Product Name",
                                icon: const Icon(
                                    Icons.production_quantity_limits),
                                title: "Product Name"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: productpriceController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Product Price";
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onFieldSubmitted: (Value) {},
                            decoration: fieldDecration(
                                hint: "Enter Product Price",
                                icon: const Icon(Icons.price_change),
                                title: "Product Price"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: productaboutController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Product Description";
                              }
                              return null;
                            },
                            maxLines: 10,
                            minLines: 3,
                            decoration: fieldDecration(
                                hint: "Enter Product Description",
                                icon: const Icon(Icons.description),
                                title: "Product Description"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: productdeliveryController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Delivery Charges";
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: fieldDecration(
                                hint: "Enter Delivery Charges",
                                icon: const Icon(Icons.description),
                                title: "Delivery Charges"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  32.height,
                  MaterialButton(
                    color: kPrimaryClr,
                    height: 60,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        EasyLoading.show();
                        upload();
                      }
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(
                          color: kWhiteClr,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  50.height,
                  16.height,
                ],
              ),
            ))
      ],
    );
  }

  InputDecoration fieldDecration({
    required String title,
    required String hint,
    required Widget icon,
    bool isalways = false,
  }) {
    return InputDecoration(
      suffixIcon: icon,
      hintText: hint,
      label: Text(
        title,
        style: const TextStyle(color: kPrimaryClr),
      ),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: radius()),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: radius()),
      floatingLabelBehavior:
          isalways ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kSecondarClr),
          borderRadius: radius()),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryClr),
          borderRadius: radius()),
    );
  }
}
