import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  final Widget child;
  final String label;
  final Color? color;
  final Color? labelColor;
  final bool visible;
  const AppBanner({super.key, required this.child, this.label = '', this.color, this.labelColor, this.visible = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if(visible)
        Positioned(
          right: -100,
          top: 30,
          child: Align(
            alignment: Alignment.topRight,
            child: Transform.rotate(
              angle: .75,
              child: Container(
                height: 30,
                width: 300,
                decoration: BoxDecoration(
                  color: color ?? Theme.of(context).primaryColor,
                ),
                child: Center(child: Text(label, style: TextStyle(color: labelColor),)),
              ),
            ),
          ),
        )
      ],
    );
  }
}