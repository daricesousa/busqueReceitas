import 'package:busque_receitas/app/core/utils/validations_field.dart';
import 'package:busque_receitas/app/core/widgets/app_button.dart';
import 'package:busque_receitas/app/core/widgets/app_form_field.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './register_controller.dart';

class RegisterPage extends GetView<RegisterController> {

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  RegisterPage({Key? key}) : super(key: key);

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
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CloseButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: context.height - 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Cadastre-se',
                        textAlign: TextAlign.center,
                        style: context.textTheme.headline3,
                      ),
                      const SizedBox(height: 10),
                      AppFormField(
                        label: 'Nome',
                        controller: controller.editName,
                        validator: (value) => Validations.name(value),
                      ),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
                      AppFormField(
                        label: 'Confirmar senha',
                        controller: controller.editConfirmPass,
                        obscuredText: true,
                        validator: (value) => Validations.confirmPassword(
                            controller.editPass.text, value),
                      ),
                      const SizedBox(height: 20),
                      Obx(() => button()),
                      const SizedBox(height: 20),
                      GestureDetector(
                        child: const Text(
                          "Já tem conta? Faça login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          Get.back();
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
      onPressed: () {
        if (_form.currentState!.validate()) {
          controller.createUser();
        }
      },
      visible: controller.loading.value,
      child: const Text("Cadastrar", style: TextStyle(fontSize: 20)),
    );
  }
}
