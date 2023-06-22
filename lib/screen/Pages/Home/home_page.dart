import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:onicame/admin/components/side_menu.dart';
import 'package:onicame/main.dart';
import 'package:onicame/screen/Pages/Home/widgets/banner.dart';
import 'package:onicame/screen/Pages/Home/widgets/cate_screen.dart';
import 'package:onicame/screen/Pages/footer/our_footer.dart';

import 'package:onicame/screen/Pages/modules/widgets/navigation_bar.dart';
import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/enums.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('products')
      .orderBy('time', descending: false)
      .snapshots();

  void genologyshow() {
    FirebaseFirestore.instance
        .collection('users')
        .where('sponsorname', isEqualTo: box.read("firstName"))
        .orderBy('createdAt', descending: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print(doc['username']);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print(box.read("uid"));
    super.initState();
  }

  List<String> cateList = [
    'Cosmetics',
    'Clothes',
    'Bags',
    'Wallet',
    'Electronics',
    'Shoes',
    'Accessories',
    'Jewelry',
  ];
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
          select: MenuState.home,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeroBanner(),

            Container(
              constraints: const BoxConstraints(maxWidth: kMaxWidth),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  //packages
                  const Text(
                    "Category",
                    textScaleFactor: 1.5,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 60,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                              dragDevices: {
                                PointerDeviceKind.touch,
                                PointerDeviceKind.mouse,
                              },
                            ),
                            child: ListView.builder(
                              itemCount: cateList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: CateScreen(
                                                cate: cateList[index],
                                              )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: kwhiteClr,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Center(
                                            child: Text(cateList[index])),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Products",
                    textScaleFactor: 1.5,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  ProductCardContainer(usersStream: _usersStream)
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              width: double.infinity,
              color: kPrimaryClr.withOpacity(0.1),
              child: Column(
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: kMaxWidth,
                    ),
                    child: Column(
                      children: [
                        _size.width <= 420
                            ? Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: kPrimaryClr,
                                        shape: BoxShape.circle,
                                        boxShadow: [kDefaultShadow]),
                                    child: CircleAvatar(
                                      radius: _size.width >= 570 ? 150 : 100,
                                      backgroundImage: const AssetImage(
                                        'images/assets/about-us-2.jpg',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Total Solutions for\nYour Business Here',
                                        textScaleFactor:
                                            _size.width >= 570 ? 1.5 : 1.0,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'With the Internet taking over a large part of our lives, more people are looking to ways to earn money online to increase their financial inflows, with secondary income streams.',
                                        style: TextStyle(
                                            fontSize:
                                                _size.width >= 570 ? 16 : 13,
                                            height: 1.5),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      MaterialButton(
                                        color: kPrimaryClr,
                                        height: 45,
                                        onPressed: () {
                                          (context).goNamed('registration');
                                        },
                                        child: Text(
                                          "Registered Now",
                                          style: TextStyle(
                                            color: kWhiteClr,
                                            fontSize:
                                                _size.width >= 570 ? 16 : 14,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: kPrimaryClr,
                                              shape: BoxShape.circle,
                                              boxShadow: [kDefaultShadow]),
                                          child: CircleAvatar(
                                            radius:
                                                _size.width >= 570 ? 150 : 100,
                                            backgroundImage: const AssetImage(
                                              'images/assets/about-us-2.jpg',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Solutions for\nYour Business Here',
                                          textScaleFactor:
                                              _size.width >= 570 ? 1.5 : 1.0,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'With the Internet taking over a large part of our lives, more people are looking to ways to earn money online to increase their financial inflows, with secondary income streams.',
                                          style: TextStyle(
                                              fontSize:
                                                  _size.width >= 570 ? 16 : 13,
                                              height: 1.5),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        MaterialButton(
                                          color: kPrimaryClr,
                                          height: 45,
                                          onPressed: () {
                                            (context).goNamed('registration');
                                          },
                                          child: Text(
                                            "Registered Now",
                                            style: TextStyle(
                                              color: kWhiteClr,
                                              fontSize:
                                                  _size.width >= 570 ? 16 : 14,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                      ],
                    ),
                  ),
                ],
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

class OurPackages extends StatefulWidget {
  const OurPackages({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);
  final String image, title;

  @override
  State<OurPackages> createState() => _OurPackagesState();
}

class _OurPackagesState extends State<OurPackages> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      onHover: (val) {
        setState(() {
          isHover = val;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: _size.width >= 936
            ? 300
            : _size.width >= 778
                ? 250
                : _size.width <= 635
                    ? _size.width
                    : 200,
        decoration: BoxDecoration(
            color: kGreyClr.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [if (isHover) kDefaultShadow]),
        child: Column(
          children: [
            SvgPicture.asset(
              widget.image,
              height: 70,
              width: 70,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(widget.title,
                style: const TextStyle(
                  // color: kWhiteClr,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "View Details",
              style: TextStyle(
                  color: kPrimaryClr,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
