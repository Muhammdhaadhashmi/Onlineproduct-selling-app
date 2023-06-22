import 'package:flutter/material.dart';
import 'package:onicame/utils/colors.dart';

class PageLabel extends StatelessWidget {
  final String label;
  const PageLabel({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: _size.width >= 550 ? 250 : 100,
      decoration: const BoxDecoration(color: kPrimaryClr),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: _size.width >= 550 ? 30 : 20,
            color: kWhiteClr,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
