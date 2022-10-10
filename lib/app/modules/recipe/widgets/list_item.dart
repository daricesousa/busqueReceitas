import 'package:flutter/material.dart';
class ListItem extends StatelessWidget {
  final Widget? leading;
  final void Function()? onTap;
  final String? text;
  const ListItem({
    super.key,
    this.leading,
    this.onTap,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap?.call,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        child: Row(
          children: [
            if (leading != null) leading!,
            const SizedBox(width: 10),
            if (text != null) Text(text!, style: TextStyle(color: Colors.grey[800]),),
          ],
        ),
      ),
    );
  }
}