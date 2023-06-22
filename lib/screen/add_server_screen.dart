// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:onicame/component/stacked_background.dart';
// import 'package:onicame/main.dart';
// import 'package:onicame/model/serverModel.dart';
// import 'package:onicame/utils/widget.dart';
// import 'package:nb_utils/nb_utils.dart';

// class AddServerScreen extends StatefulWidget {
//   ServerModel? updateData;

//   AddServerScreen({this.updateData, Key? key}) : super(key: key);

//   @override
//   _AddServerScreenState createState() => _AddServerScreenState();
// }

// class _AddServerScreenState extends State<AddServerScreen> {
//   final _formKey = GlobalKey<FormState>();

//   TextEditingController nameCont = TextEditingController();
//   TextEditingController flagCont = TextEditingController();
//   TextEditingController ovpnFileCont = TextEditingController();

//   FocusNode nameFocus = FocusNode();
//   FocusNode flagFocus = FocusNode();
//   FocusNode fileNameFocus = FocusNode();
//   FocusNode usernameFocus = FocusNode();
//   FocusNode passwordFocus = FocusNode();

//   String fileName = '';
//   String filePath = '';

//   FilePickerResult? countryFlagImage;
//   FilePickerResult? selectedOvpnFile;

//   bool isUpdate = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   void submit() async {
//     CollectionReference banner =
//         FirebaseFirestore.instance.collection('banner');

//     appStore.setIsLoading(true);

//     if (countryFlagImage != null) {
//       String imageUrl = await userService.getUploadedImageURLFromWeb(
//           image: countryFlagImage!.files.first.bytes!,
//           path: "flags",
//           fileName: nameCont.text.toLowerCase(),
//           extension: countryFlagImage!.files.first.extension!);

//       // Call the user's CollectionReference to add a new user
//       return banner
//           .add({
//             'image': imageUrl, // John Doe
//           })
//           .then((value) => print("User Added"))
//           .catchError((error) => print("Failed to add user: $error"));
//     }
//   }

//   Future<FilePickerResult?> getFiles({String? message}) async {
//     return await FilePicker.platform
//         .pickFiles(type: FileType.image, dialogTitle: message);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: _formKey,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         child: StackedBackground(
//           child: SingleChildScrollView(
//             child: Container(
//               alignment: Alignment.center,
//               width: context.width() * 0.3,
//               padding: EdgeInsets.all(16),
//               decoration: boxDecorationDefault(),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Image.asset(appImages.appIcon, height: 100, fit: BoxFit.cover)
//                       .center(),
//                   16.height,
//                   Text(isUpdate ? 'Update OVPN Server' : 'Add OVPN Server',
//                           style: boldTextStyle())
//                       .center(),
//                   16.height,
//                   AppTextField(
//                     textFieldType: TextFieldType.NAME,
//                     controller: nameCont,
//                     nextFocus: flagFocus,
//                     onFieldSubmitted: (s) {
//                       setState(() {});
//                     },
//                     decoration: inputDecoration(
//                         labelText: 'Server Name', icon: Icon(Icons.web_asset)),
//                   ),
//                   16.height,
//                   AppTextField(
//                     textFieldType: TextFieldType.NAME,
//                     controller: flagCont,
//                     readOnly: true,
//                     decoration: inputDecoration(
//                             labelText: 'Country Flag', icon: Icon(Icons.flag))
//                         .copyWith(
//                       suffixIcon: AppButton(
//                         text: 'Select',
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 4, vertical: 16),
//                         shapeBorder: RoundedRectangleBorder(
//                             borderRadius: radius(defaultRadius)),
//                         onTap: () async {
//                           countryFlagImage =
//                               await getFiles(message: "Select Country Flag");
//                           if (countryFlagImage != null) {
//                             flagCont.text = "Flag selected";
//                             setState(() {});
//                           }
//                         },
//                       ).paddingRight(8),
//                     ),
//                   ),
//                   if (countryFlagImage != null)
//                     Image.memory(countryFlagImage!.files.first.bytes!,
//                         height: 60, width: 60),
//                   16.height,
//                   16.height,
//                   AppButton(
//                     text: 'Submit',
//                     width: context.width(),
//                     shapeBorder:
//                         RoundedRectangleBorder(borderRadius: radius(16)),
//                     onTap: () {
//                       if (isUpdate) {
//                         if (_formKey.currentState!.validate()) {
//                           _formKey.currentState!.save();

//                           showConfirmDialogCustom(
//                             context,
//                             title:
//                                 "Are you sure you want to update ${nameCont.text} server?",
//                             dialogType: DialogType.UPDATE,
//                             onAccept: (c) {},
//                           );
//                         }
//                       } else {
//                         if (_formKey.currentState!.validate()) {
//                           _formKey.currentState!.save();
//                           showConfirmDialogCustom(
//                             context,
//                             title:
//                                 "Are you sure you want to add ${nameCont.text} server?",
//                             dialogType: DialogType.ADD,
//                             onAccept: (c) {
//                               submit();
//                             },
//                           );
//                         }
//                       }
//                     },
//                   ),
//                 ],
//               ).center(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
