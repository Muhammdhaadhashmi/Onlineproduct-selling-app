import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onicame/utils/colors.dart';

//change the name of class
class HeroBanner extends StatefulWidget {
  const HeroBanner({Key? key}) : super(key: key);

  @override
  _HeroBannerState createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  int index = 0;
  final List<String> _getImage = [];

  @override
  void initState() {
    // TODO: implement initState
    assignImage();
    super.initState();
  }

  int dotlength = 0;

  assignImage() {
    FirebaseFirestore.instance
        .collection('banner')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        _getImage.add(doc['image']);
        print(dotlength);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        20.height,
        Container(
          constraints: const BoxConstraints(
            maxWidth: kMaxWidth,
          ),
          child: Column(
            children: [
              CarouselSlider(
                items: _getImage
                    .map((item) => SliderCard(
                          image: item,
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: _size.width >= 850
                        ? 400
                        : _size.width >= 650
                            ? 250
                            : _size.width <= 420
                                ? 150
                                : 250,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (int p, CarouselPageChangedReason) {
                      setState(() {
                        index = p;
                      });
                    }),
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('banner').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("");
                  }

                  return DotsIndicator(
                    dotsCount: snapshot.data!.docs.length,
                    position: index.toDouble(),
                    decorator: DotsDecorator(
                      activeColor: kPrimaryClr.withOpacity(0.5),
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SliderCard extends StatelessWidget {
  const SliderCard({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      color: kPrimaryClr.withOpacity(0.2),
      child: Image.network(
        image,
        width: _size.width,
        fit: BoxFit.fill,
      ),
    );
  }
}
