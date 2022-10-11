import 'package:flutter/material.dart';

class AppRating extends StatefulWidget {
  final void Function(int)? onTap;
  final int initialValue;
  const AppRating({Key? key, this.onTap, this.initialValue = -1})
      : super(key: key);

  @override
  State<AppRating> createState() => _AppRatingState();
}

class _AppRatingState extends State<AppRating> {
  int avaliable = -1;

  @override
  void initState() {
    avaliable = widget.initialValue - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          child: Visibility(
            visible: index <= avaliable,
            replacement: const Icon(Icons.star_border),
            child: const Icon(Icons.star),
          ),
          onTap: () {
            if (avaliable != index) {
              setState(() => avaliable = index);
              widget.onTap?.call(index + 1);
            }
          },
        );
      }),
    );
  }
}
