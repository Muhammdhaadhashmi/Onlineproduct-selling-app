import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:onicame/main.dart';

import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/constants.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:uuid/uuid.dart';

import '../../../components/usersidebar.dart';

class EditsupportScreen extends StatefulWidget {
  static const String id = '/editsupport';
  const EditsupportScreen({Key? key}) : super(key: key);

  @override
  _EditsupportScreenState createState() => _EditsupportScreenState();
}

class _EditsupportScreenState extends State<EditsupportScreen> {
  final _formKey = GlobalKey<FormState>();
  var stateTextController = TextEditingController();
  var addressTextController = TextEditingController();

  var datebirthTextController = TextEditingController();

  var lastnameTextController = TextEditingController();

  var cnicTextController = TextEditingController();

  var firstnameTextController = TextEditingController();

  var sponsernameTextController = TextEditingController();

  var emailTextController = TextEditingController();

  var usernameTextController = TextEditingController();

  var passwordTextController = TextEditingController();

  var mobTextController = TextEditingController();

  var confirmpasswordTextController = TextEditingController();

  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();

  bool isvisible = true;
  bool iscvisible = true;
  bool confirmisvisible = true;
  String _titlename = "Mr.";
  List<String> titlenameList = [
    'Mr.',
    'Miss.',
    'Mrs.',
    'Ms.',
  ];
  DateTime _selectedDate = DateTime.now();
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  var email = '';
  var password = '';
  var username = '';
  var sponsernamename = '';
  var title = '';
  var cnic = '';
  var datebirth = '';
  var countryname = '';
  var statename = '';
  var addressname = '';
  var pnumber = '';
  var fuser = '';
  var luser = '';
  List<Widget> itemPhotosWidgetList = <Widget>[];

  final ImagePicker _picker = ImagePicker();
  File? file;
  List<XFile>? photo = <XFile>[];
  List<XFile> itemImagesList = <XFile>[];

  List<String> downloadUrl = <String>[];

  bool uploading = false;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Call the user's CollectionReference to add a new user
      return users
          .doc(box.read("uid"))
          .update({
            "firstName": firstnameTextController.text,
            'lastname': lastnameTextController.text,
            'cnicNo': cnicTextController.text,
            'dateofbirth': datebirth,
            'country': countryname,
            'state': statename,
            'address': addressTextController.text,
            'title': _titlename,
            'mobileno': mobTextController.text,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"))
          .whenComplete(() => EasyLoading.dismiss());
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(box.read("uid"))
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        // stateTextController.text = documentSnapshot[''];
        addressTextController.text = documentSnapshot['address'];

        datebirthTextController.text = documentSnapshot['dateofbirth'];

        lastnameTextController.text = documentSnapshot['lastname'];

        cnicTextController.text = documentSnapshot['cnicNo'];

        firstnameTextController.text = documentSnapshot['firstName'];

        sponsernameTextController.text = documentSnapshot['sponsorname'];

        emailTextController.text = documentSnapshot['email'];

        usernameTextController.text = documentSnapshot['username'];

        passwordTextController.text = documentSnapshot['password'];

        mobTextController.text = documentSnapshot['mobileno'];
      }
    });

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
              child: Container(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Edit Details",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Center(
                                      child: Text(
                                        "Profile Pic",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Material(
                                          elevation: 5,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white70,
                                            ),
                                            width: 150,
                                            height: 150,
                                            child: Center(
                                              child: itemPhotosWidgetList
                                                      .isEmpty
                                                  ? Center(
                                                      child: MaterialButton(
                                                        onPressed:
                                                            pickPhotoFromGallery,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: Center(
                                                            child:
                                                                Image.network(
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
                                                        children:
                                                            itemPhotosWidgetList,
                                                      ),
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 15.0),
                                              color: kPrimaryClr,
                                              onPressed: uploading
                                                  ? null
                                                  : () => upload(),
                                              child: uploading
                                                  ? const SizedBox(
                                                      child:
                                                          CircularProgressIndicator(),
                                                      height: 15.0,
                                                    )
                                                  : const Text(
                                                      "Add",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                        ),
                                      ],
                                    ),
                                    //title

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: fieldDecration(
                                            hint: _titlename,
                                            icon: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: DropdownButton(
                                                isExpanded: true,
                                                hint: Text(_titlename),
                                                focusColor: kPrimaryClr,
                                                underline: Container(
                                                  height: 0,
                                                  color: Colors.transparent,
                                                ),
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    _titlename = newValue!;
                                                  });
                                                },
                                                items: titlenameList.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                          String>(
                                                      value: value,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          value.toString(),
                                                          style: const TextStyle(
                                                              color:
                                                                  kPrimaryClr),
                                                        ),
                                                      ));
                                                }).toList(),
                                              ),
                                            ),
                                            title: "Title",
                                            isalways: true),
                                      ),
                                    ),
                                    //first name
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: TextFormField(
                                        controller: firstnameTextController,
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter First Name";
                                          }
                                          return null;
                                        },
                                        decoration: fieldDecration(
                                            hint: "Enter Your First Name",
                                            icon: const Icon(Icons.person),
                                            title: "First Name"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2.5,
                                    ),
                                    const Text(
                                      "Please enter your First Name as it appears on your photo ID",
                                    ),

                                    //last name
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        controller: lastnameTextController,
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter Last Name";
                                          }
                                          return null;
                                        },
                                        decoration: fieldDecration(
                                            hint: "Enter Your Last Name",
                                            icon: const Icon(Icons.person),
                                            title: "Last Name"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2.5,
                                    ),
                                    const Text(
                                      "Please enter your Last Name as it appears on your photo ID",
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),

                                    //number
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: TextFormField(
                                        controller: mobTextController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter Mobile No";
                                          }
                                          return null;
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        maxLength: 11,
                                        decoration: fieldDecration(
                                            hint: "Enter Your Mobile No",
                                            icon: const Icon(Icons
                                                .format_indent_decrease_rounded),
                                            title: "Mobile No"),
                                      ),
                                    ),
                                    //Id Number
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: TextFormField(
                                        controller: cnicTextController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        maxLength: 13,
                                        decoration: fieldDecration(
                                            hint: "Enter Your CNIC No",
                                            icon: const Icon(Icons
                                                .format_indent_decrease_rounded),
                                            title: "CNIC No"),
                                      ),
                                    ),
                                    //birthdate
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: TextFormField(
                                        readOnly: true,
                                        keyboardType: TextInputType.number,
                                        decoration: fieldDecration(
                                            hint: DateFormat.yMd()
                                                .format(_selectedDate),
                                            icon: IconButton(
                                                onPressed: () {
                                                  _getDateFormuser(context);
                                                },
                                                icon: const Icon(Icons.date_range)),
                                            title: "Date of Birth"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //country
                                    CSCPicker(
                                      flagState: CountryFlag.DISABLE,
                                      showCities: false,
                                      countryDropdownLabel: 'Country',
                                      stateDropdownLabel: 'State',
                                      selectedItemStyle: const TextStyle(
                                          color: kPrimaryClr,
                                          fontWeight: FontWeight.w600),
                                      onCountryChanged: (convalue) {
                                        setState(() {
                                          countryValue = convalue;
                                          print(country.text);
                                        });
                                      },
                                      onStateChanged: (statvalue) {
                                        setState(() {
                                          stateValue = statvalue.toString();

                                          print(stateValue);
                                        });
                                      },
                                      onCityChanged: (value) {
                                        setState(() {
                                          value = cityValue;
                                        });
                                      },
                                    ),
                                    //address
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: TextFormField(
                                        controller: addressTextController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter Address";
                                          }
                                          //now we use email validator package

                                          return null;
                                        },
                                        decoration: fieldDecration(
                                            hint: 'Enter Your Address',
                                            icon: const Icon(Icons.email),
                                            title: 'Address'),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 30,
                                    ),
                                    //sign Up Button

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    MaterialButton(
                                      color: kPrimaryClr,
                                      minWidth: double.infinity,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      height: 50,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            datebirth = DateFormat.yMd()
                                                .format(_selectedDate);
                                            statename = stateValue;
                                            countryname = countryValue;
                                            EasyLoading.show();
                                            submit();
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return const KFC();
                                                });
                                          });
                                        }
                                      },
                                      child: const Text(
                                        "Update",
                                        style: TextStyle(
                                          color: kWhiteClr,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ))
        ]));
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
        .doc(box.read("uid"))
        .update({
          'photoUrl': value,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  _getDateFormuser(context) async {
    DateTime? _pickdate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2121));
    if (_pickdate != null) {
      setState(() {
        _selectedDate = _pickdate;
        print(_selectedDate);
      });
    } else {
      print("Something went wrong");
    }
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
          borderSide: const BorderSide(color: Colors.red), borderRadius: radius()),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red), borderRadius: radius()),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kSecondarClr), borderRadius: radius()),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryClr), borderRadius: radius()),
    );
  }
}

class KFC extends StatefulWidget {
  const KFC({Key? key}) : super(key: key);

  @override
  _KFCState createState() => _KFCState();
}

class _KFCState extends State<KFC> {
  List<Widget> itemPhotosWidgetList = <Widget>[];
  CollectionReference delban =
      FirebaseFirestore.instance.collection('usersIncome');
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('usersIncome')
      .where('userid', isEqualTo: box.read("uid"))
      .snapshots();
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

    return Dialog(
      child: OKToast(
          child: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    32.height,
                    const Text(
                      "KYC Upload ID Card Image",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
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
      )),
    );
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
        FirebaseFirestore.instance.collection('usersIncome');

    return banner
        .doc(box.read("uid"))
        .update({
          'image': value,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
