import 'package:busque_receitas/app/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class ErroPage extends StatefulWidget {
  final bool visible;
  final dynamic Function() onPressed;

  const ErroPage({
    Key? key,
    required this.visible,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<ErroPage> createState() => _ErroPageState();
}

class _ErroPageState extends State<ErroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: body(),
    );
  }

  Widget body() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Conecte-se a internet",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
          Container(height: 10),
          AppButton(
            visible: widget.visible,
            onPressed: widget.onPressed,
            child: const Text("Tentar novamente", style: TextStyle(fontSize: 20)),
          ),
        ]);
  }
}
