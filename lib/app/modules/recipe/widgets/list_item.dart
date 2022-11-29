import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Widget? leading;
  final Widget? child;
  final double? padding_leading;
  final double? padding_child;
  final void Function()? onTap;
  final String? text;
  const ListItem({
    super.key,
    this.leading,
    this.onTap,
    this.text,
    this.padding_leading,
    this.padding_child = 10,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap?.call,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        child: Row(
          children: [
            SizedBox(width: padding_leading),
            if (leading != null) leading!,
            SizedBox(width: padding_child),
            if (text != null)
              Expanded(
                child:
                    Text(text!, style: const TextStyle(color: AppColor.dark)),
              ),
            if(child != null) child!,
          ],
        ),
      ),
    );
  }
}
