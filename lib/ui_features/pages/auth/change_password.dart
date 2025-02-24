import 'package:flutter/material.dart';
import 'package:ukost/app/repositories/auth/auth_repository.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/export.dart';
import 'package:ukost/config/session_manager.dart';
import 'package:ukost/ui_features/components/buttons/primary_button.dart';
import 'package:ukost/ui_features/components/inputs/textfield_primary.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController passwordController = TextEditingController(),
      confirmController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Ubah Password"),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            children: [
              TextFieldPrimary(
                label: "Password",
                obs: true,
                hintText: "Password Baru",
                controller: passwordController,
              ),
              TextFieldPrimary(
                validator: (e) {
                  if (confirmController.text != passwordController.text) {
                    return "Password tidak sama";
                  }
                  return null;
                },
                label: "Konfirmasi Password",
                obs: true,
                hintText: "Konfirmasi Password",
                controller: confirmController,
              ),
              verticalSpace(10),
              ValueListenableBuilder(
                valueListenable: loading,
                builder: (context, value, _) {
                  return PrimaryButton(
                    color: ColorAsset.violet,
                    label: "Submit",
                    radius: 8,
                    loading: loading.value,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        Map<String, dynamic> request = {
                          "password": passwordController.text,
                        };
                        loading.value = true;
                        var res = await AuthRepository.changePassword(request);
                        loading.value = false;
                        if (res) {
                          SessionManager.clearSession();
                        }
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
