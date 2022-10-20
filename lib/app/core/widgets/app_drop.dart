import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:flutter/material.dart';

class AppDrop<T> extends StatelessWidget {
  final String label;
  final String inputInfo;
  final Widget? childSelectedBuilder;
  final int maxLines;
  final Function(T?)? onChange;

  final List<DropdownMenuItem<T>>? list;

  const AppDrop({
    Key? key,
    required this.label,
    required this.list,
    required this.onChange,
    this.maxLines = 1,
    this.childSelectedBuilder,
    this.inputInfo = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: inputInfo.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(left: 5, top: 5),
            child: Text(inputInfo),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.dark1)),
          child: DropdownButton<T>(
            onTap: FocusScope.of(context).unfocus,
            disabledHint: const SizedBox(width: 100, height: 50),
            dropdownColor: Colors.white,
            isExpanded: true,
            items: list,
            underline: Container(),
            onChanged: onChange,
            hint: childSelectedBuilder ??
                Text(
                  label,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
          ),
        ),
      ],
    );
  }
}