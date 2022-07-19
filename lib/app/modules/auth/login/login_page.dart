import 'package:busque_receitas/app/core/utils/validations.dart';
import 'package:busque_receitas/app/core/widgets/app_button.dart';
import 'package:busque_receitas/app/core/widgets/app_form_field.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: CloseButton(),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: context.height - 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: controller.form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: context.textTheme.headline3,
                      ),
                      const SizedBox(height: 20),
                      AppFormField(
                        label: 'Email',
                        controller: controller.editEmail,
                        validator: (value) => Validations.email(value),
                      ),
                      const SizedBox(height: 10),
                      AppFormField(
                        label: 'Senha',
                        controller: controller.editPass,
                        obscuredText: true,
                        validator: (value) => Validations.password(value),
                      ),
                      const SizedBox(height: 20),
                      Obx(() => button()),
                      const SizedBox(height: 20),
                      GestureDetector(
                        child: const Text(
                          "Não tem conta? Cadastre-se",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          Get.toNamed('/register');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget button() {
    return AppButton(
      onPressed: controller.login,
      label: "Entrar",
      visible: controller.loading.value,
    );
  }
}
