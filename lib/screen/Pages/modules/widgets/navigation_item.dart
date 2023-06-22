import 'package:flutter/material.dart';
import 'package:onicame/utils/colors.dart';

class NavigationItem extends StatefulWidget {
  final String title;

  final VoidCallback press;
  bool isActive;

  NavigationItem({
    Key? key,
    this.isActive = false,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return InkWell(
        onTap: widget.press,
        child: Container(
          color: kWhiteClr,
          child: Text(
            widget.title,
            style: TextStyle(
              color: isHover ? kPrimaryClr : kSecondarClr,
              fontSize: _size.width >= 400 ? 16 : 13,
              fontWeight: isHover ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ));
  }
}
