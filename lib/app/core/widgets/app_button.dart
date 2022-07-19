import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String label;
  final bool visible;
  final Function() onPressed;

  const AppButton({
    Key? key,
    this.label = '',
    required this.onPressed,
    this.visible = false,
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
          ),
          child: Visibility(
            visible: widget.visible,
            replacement: Text(
              widget.label,
              style: const TextStyle(fontSize: 20),
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
