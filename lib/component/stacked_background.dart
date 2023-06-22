import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class StackedBackground extends StatelessWidget {
  final Widget child;
  final bool showBackButton;

  const StackedBackground({required this.child, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            color: Colors.white,
            height: context.height(),
            width: context.width()),
        // Image.asset(appImages.singingBackground,
        //     fit: BoxFit.cover,
        //     height: context.height(),
        //     width: context.width()),
        child.center(),
        if (showBackButton)
          Positioned(
            top: 16,
            left: 16,
            child: BackButton(
              onPressed: () {
                finish(context);
              },
            ),
          ),
        // Observer(builder: (context) => Loader().visible(appStore.isLoading)),
      ],
    );
  }
}
