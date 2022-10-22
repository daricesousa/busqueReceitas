import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscuredText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onSubmit;
  final int maxLines;
  final int minLines;
  final double? labelFontSize;
  final String? initialValue;

  const AppFormField({
    Key? key,
    this.controller,
    this.label = '',
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.validator,
    this.obscuredText = false,
    this.onChanged,
    this.onSubmit,
    this.maxLines = 1,
    this.minLines = 1,
    this.labelFontSize,
    this.initialValue,
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
        initialValue: widget.initialValue,
        controller: widget.controller,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatters,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.obscuredText,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onFieldSubmitted: (v){
           widget.onSubmit?.call();
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            labelStyle: TextStyle(fontSize: widget.labelFontSize),
            labelText: widget.label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
