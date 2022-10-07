import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String label;
  final bool visible;
  final Color? color;
  final Color? textColor;
  final Function() onPressed;

  const AppButton({
    Key? key,
    this.label = '',
    required this.onPressed,
    this.visible = false,
    this.color,
    this.textColor, 
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            backgroundColor: widget.color !=null ? MaterialStateProperty.all(widget.color): null,
          ),
          child: Visibility(
            visible: widget.visible,
            replacement: Text(
              widget.label,
              style: TextStyle(fontSize: 20, color: widget.textColor),
            ),
            child: const SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
