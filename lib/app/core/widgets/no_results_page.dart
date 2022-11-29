import 'package:busque_receitas/app/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class NoResultsPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool visible;
  final dynamic Function() onPressed;

  const NoResultsPage({
    Key? key,
    this.visible = false,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<NoResultsPage> createState() => _NoResultsPageState();
}

class _NoResultsPageState extends State<NoResultsPage> {
  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.title,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: 20)),
          Container(height: 10),
          AppButton(
            visible: widget.visible,
            onPressed: widget.onPressed,
            child: Text (widget.subtitle, style: const TextStyle(fontSize: 20)),
          ),
        ]);
  }
}
