import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/app/repositories/auth/auth_repository.dart';
import 'package:ukost/config/assets.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/config/session_manager.dart';
import 'package:ukost/config/snackbar.dart';
import 'package:ukost/ui_features/components/buttons/primary_button.dart';
import 'package:ukost/ui_features/components/carousel/carousel.dart';
import 'package:ukost/ui_features/components/inputs/textfield_primary.dart';
import 'package:ukost/ui_features/layout/template.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  ValueNotifier<bool> isObs = ValueNotifier(false);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      if (context.mounted) {
        SessionManager.getSession();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const Carousel(
                images: [
                  Assets.carousel1,
                  Assets.carousel2,
                  Assets.carousel3,
                ],
              ),
              verticalSpace(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Masuk",
                          style: GoogleFonts.inter(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset(
                          Assets.logo,
                          width: 41,
                          height: 46,
                        ),
                      ],
                    ),
                    verticalSpace(10),
                    Text(
                      "Selamat datang di sistem manajemen kost, silahkan\nmasukkan email dan password anda yang terdaftar\ndi sistem untuk memulai penggunaan aplikasi ini.",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    verticalSpace(30),
                    TextFieldPrimary(
                      controller: emailController,
                      label: "Email",
                      isRaw: true,
                      hintText: "contoh@domain",
                    ),
                    verticalSpace(20),
                    ValueListenableBuilder(
                      valueListenable: isObs,
                      builder: (context, value, _) {
                        return TextFieldPrimary(
                          label: "Password",
                          controller: passwordController,
                          isRaw: true,
                          hintText: "*************",
                          suffixIcon: IconButton(
                            onPressed: () {
                              isObs.value = !isObs.value;
                            },
                            icon: Icon(
                              !isObs.value
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                          obs: !isObs.value,
                        );
                      },
                    ),
                    verticalSpace(30),
                    ValueListenableBuilder(
                      valueListenable: loading,
                      builder: (context, value, _) {
                        return PrimaryButton(
                          loading: loading.value,
                          radius: 6,
                          label: "Login",
                          color: ColorAsset.violet,
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              loading.value = true;
                              var res = await AuthRepository.login(
                                emailController.text,
                                passwordController.text,
                              );
                              loading.value = false;
                              if (res) {
                                await SessionManager.setSession();
                                nextReplace(const Template());
                              }
                            }
                          },
                        );
                      },
                    ),
                    verticalSpace(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Lupa Password? ",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Snackbar.error("Fitur belum tersedia");
                          },
                          child: Text(
                            "Ubah Password",
                            style: GoogleFonts.inter(
                              color: ColorAsset.violet,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
