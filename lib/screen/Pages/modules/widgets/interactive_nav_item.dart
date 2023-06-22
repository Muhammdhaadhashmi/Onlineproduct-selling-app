// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:mlm_website/utilities/constants.dart';

// import 'package:universal_html/html.dart' as html;

// class InteractiveNavItem extends MouseRegion {
//   static final appContainer =
//       html.window.document.querySelectorAll('flt-glass-pane')[0];

//   InteractiveNavItem(
//       {Key? key,
//       Widget? child,
//       String? text,
//       String? routeName,
//       bool? selected})
//       : super(
//           key: key,
//           onHover: (PointerHoverEvent evt) {
//             appContainer.style.cursor = 'pointer';
//           },
//           onExit: (PointerExitEvent evt) {
//             appContainer.style.cursor = 'default';
//           },
//           child: InteractiveText(
//             text: text!,
//             routeName: routeName!,
//             selected: selected!,
//           ),
//         );
// }

// class InteractiveText extends StatefulWidget {
//   final String text;
//   final String routeName;
//   final bool selected;

//   const InteractiveText({
//     Key? key,
//     required this.text,
//     required this.routeName,
//     required this.selected,
//   }) : super(key: key);

//   @override
//   InteractiveTextState createState() => InteractiveTextState();
// }

// class InteractiveTextState extends State<InteractiveText> {
//   bool _hovering = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onHover: (_) => _hovered(true),
//       onExit: (_) => _hovered(false),
//       child: Text(widget.text,
//           style: _hovering
//               ? const TextStyle(
//                   color: kPrimaryClr,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 )
//               : (widget.selected)
//                   ? const TextStyle(
//                       color: kPrimaryClr,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                     )
//                   : const TextStyle(
//                       fontSize: 16,
//                       color: kSecondarClr,
//                     )),
//     );
//   }

//   _hovered(bool hovered) {
//     setState(() {
//       _hovering = hovered;
//     });
//   }
// }
