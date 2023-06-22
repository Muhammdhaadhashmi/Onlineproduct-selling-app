import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:onicame/admin/components/side_menu.dart';
import 'package:onicame/component/label.dart';
import 'package:onicame/screen/Pages/footer/our_footer.dart';
import 'package:onicame/screen/Pages/modules/widgets/navigation_bar.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/enums.dart';

class AboutPage extends StatefulWidget {
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('aboutus').snapshots();
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
          select: MenuState.about,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageLabel(label: 'About Us'),
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
                          StreamBuilder<QuerySnapshot>(
                            stream: _usersStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              return Column(
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  return Column(
                                    children: [
                                      Text(
                                        data['heading'],
                                        textScaleFactor: 2.5,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      MarkdownBody(
                                        softLineBreak: true,
                                        selectable: true,
                                        data: data['description'],
                                        shrinkWrap: true,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            //footor
            const FooterOur(),
          ],
        ),
      ),
    );
  }
}
