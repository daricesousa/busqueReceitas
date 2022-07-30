import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscuredText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AppFormField({
    Key? key,
    this.controller,
    this.label = '',
    this.textInputType = TextInputType.text,
    this.inputFormatters,
    this.validator,
    this.obscuredText = false,
    this.onChanged,
  }) : super(key: key);

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.textInputType,
        textInputAction: TextInputAction.next,
        inputFormatters: widget.inputFormatters,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.obscuredText,
        validator: widget.validator,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            labelText: widget.label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
