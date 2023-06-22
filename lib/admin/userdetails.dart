import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onicame/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class UserDetailsData extends StatefulWidget {
  final String id;
  const UserDetailsData({Key? key, required this.id}) : super(key: key);

  @override
  _UserDetailsDataState createState() => _UserDetailsDataState();
}

class _UserDetailsDataState extends State<UserDetailsData> {
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
  var packagenameTextController = TextEditingController();
  var packagepriceTextController = TextEditingController();

  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();

  bool isvisible = true;
  bool iscvisible = true;
  bool confirmisvisible = true;
  final String _titlename = "Mr.";
  List<String> titlenameList = [
    'Mr.',
    'Miss.',
    'Mrs.',
    'Ms.',
  ];
  final DateTime _selectedDate = DateTime.now();
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
  String image = '';
  String payimage = '';
  @override
  void initState() {
    getidcardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
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
        image = documentSnapshot['photoUrl'];
        packagenameTextController.text = documentSnapshot['packagename'];

        payimage = documentSnapshot['invoice'];
      }
    });
    Size _size = MediaQuery.of(context).size;
    return Dialog(
        child: Container(
      child: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(widget.id).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
              children: [
                Column(
                  children: [
                    const Text(
                      "Details",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                //supsor name=====================
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                      color: kSecondarClr,
                                      shape: BoxShape.circle),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      image == ""
                                          ? 'https://static.thenounproject.com/png/3322766-200.png'
                                          : image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: sponsernameTextController,
                                    keyboardType: TextInputType.name,
                                    onChanged: (String val) {
                                      setState(() {});
                                    },
                                    decoration: fieldDecration(
                                        hint: "Enter Sponsor's Username",
                                        icon: const Icon(Icons.person),
                                        title: "Sponsor's Username"),
                                  ),
                                ),
                                16.height,
                                //title

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    readOnly: true,
                                    decoration: fieldDecration(
                                        hint: _titlename,
                                        icon: const Icon(Icons.person),
                                        title: "Title",
                                        isalways: true),
                                  ),
                                ),
                                //first name
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: firstnameTextController,
                                    keyboardType: TextInputType.name,
                                    decoration: fieldDecration(
                                        hint: "Enter Your First Name",
                                        icon: const Icon(Icons.person),
                                        title: "First Name"),
                                  ),
                                ),

                                //last name
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: lastnameTextController,
                                    decoration: fieldDecration(
                                        hint: "Enter Your Last Name",
                                        icon: const Icon(Icons.person),
                                        title: "Last Name"),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: TextFormField(
                                    controller: usernameTextController,
                                    readOnly: true,
                                    decoration: fieldDecration(
                                        hint: "Enter Your Username",
                                        icon: const Icon(Icons.person),
                                        title: "Username"),
                                  ),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                //email
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    controller: emailTextController,
                                    readOnly: true,
                                    decoration: fieldDecration(
                                        hint: 'Enter Your Email',
                                        icon: const Icon(Icons.email),
                                        title: 'Email'),
                                  ),
                                ),

                                //number
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(
                                    controller: mobTextController,
                                    decoration: fieldDecration(
                                        hint: "Enter Your Mobile No",
                                        icon: const Icon(Icons
                                            .format_indent_decrease_rounded),
                                        title: "Mobile No"),
                                  ),
                                ),
                                //Id Number
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(
                                    readOnly: true,
                                    decoration: fieldDecration(
                                        hint: 'Please Enter Date of Birth',
                                        icon: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.date_range)),
                                        title: "Date of Birth"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                //country
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: country,
                                    decoration: fieldDecration(
                                        hint: 'Enter Your Country',
                                        icon: const Icon(Icons.email),
                                        title: 'Country'),
                                  ),
                                ),
                                //state
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: stateTextController,
                                    decoration: fieldDecration(
                                        hint: 'Enter Your State',
                                        icon: const Icon(Icons.email),
                                        title: 'State'),
                                  ),
                                ),
                                //address
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: addressTextController,
                                    decoration: fieldDecration(
                                        hint: 'Enter Your Address',
                                        icon: const Icon(Icons.email),
                                        title: 'Address'),
                                  ),
                                ),
                                //pasword
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(
                                    obscureText: false,
                                    controller: passwordTextController,
                                    decoration: fieldDecration(
                                        hint: "Enter Your Password",
                                        icon: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.visibility)),
                                        title: "Password"),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(
                                    obscureText: false,
                                    controller: packagenameTextController,
                                    decoration: fieldDecration(
                                        hint: "Package Name",
                                        icon: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.visibility)),
                                        title: "Package Name"),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(
                                    obscureText: false,
                                    controller: packagepriceTextController,
                                    decoration: fieldDecration(
                                        hint: "Package Price",
                                        icon: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.visibility)),
                                        title: "Package Price"),
                                  ),
                                ),

                                const SizedBox(
                                  height: 30,
                                ),
                                const Text("Invoice Images"),
                                payimage.isEmpty
                                    ? Container(
                                        color: kPrimaryClr,
                                        child: const Text("No invoice Image "))
                                    : Image.network(
                                        payimage,
                                        height: 150,
                                        width: 150,
                                      ),

                                const Text("ID Card Images"),
                                idcard.isEmpty
                                    ? Container(
                                        color: kPrimaryClr,
                                        child: const Text("No ID Card "))
                                    : Image.network(
                                        idcard,
                                        height: 150,
                                        width: 150,
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
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }

  String idcard = '';

  getidcardData() {
    FirebaseFirestore.instance
        .collection('usersIncome')
        .doc(widget.id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        idcard = documentSnapshot['image'];
      }
    });
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
