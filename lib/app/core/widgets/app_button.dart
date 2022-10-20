import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final Widget child;
  final bool visible;
  final Color? color;
  final Color? borderColor;
  final double? width;
  final Function() onPressed;

  const AppButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.visible = false,
    this.color,
    this.borderColor,
    this.width,
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: widget.width,
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: widget.borderColor != null
                    ? BorderSide(color: widget.borderColor!)
                    : BorderSide.none,
              ),
            ),
            backgroundColor: widget.color != null
                ? MaterialStateProperty.all(widget.color)
                : null,
          ),
          child: Visibility(
            visible: widget.visible,
            replacement: widget.child,
            child: const SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                color: AppColor.light5,
              ),
            ),
          )),
    );
  }
}
