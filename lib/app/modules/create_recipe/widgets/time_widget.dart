import 'package:flutter/material.dart';
import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:get/get.dart';

class TimeWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget appDrop;
  final BuildContext context;

  const TimeWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.appDrop,
      required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColor.dark2),
        const SizedBox(width: 10),
        SizedBox(
          width: context.width / 2,
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
          child: appDrop,
        )
      ],
    );
  }
}
