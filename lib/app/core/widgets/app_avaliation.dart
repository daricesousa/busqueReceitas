import 'package:busque_receitas/app/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppAvaliation extends StatelessWidget {
  const AppAvaliation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(maxHeight: 300),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Avaliação",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          Image.asset("assets/images/splash.png", height: 50),
          const Text("Ajude a melhorar o Busque Receitas respondendo esse formulário",
              style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
          AppButton(
            onPressed: () {
              launchUrl(
                Uri.parse("https://forms.gle/dD8Vib8zP9KbGK276"),
                mode: LaunchMode.externalApplication,
              );
            },
            child: const Text("Acesse o formulário"),

          ),
        ],
      ),
    ));
  }
}
