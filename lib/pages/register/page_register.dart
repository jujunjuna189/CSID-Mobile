import 'package:csid_mobile/pages/register/bloc/bloc_register.dart';
import 'package:csid_mobile/routes/route_name.dart';
import 'package:csid_mobile/utils/asset/asset.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:csid_mobile/widgets/atoms/button/button.dart';
import 'package:csid_mobile/widgets/atoms/button/button_outline.dart';
import 'package:csid_mobile/widgets/atoms/field/field_password.dart';
import 'package:csid_mobile/widgets/atoms/field/field_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageRegister extends StatelessWidget {
  const PageRegister({super.key});

  @override
  Widget build(BuildContext context) {
    BlocRegister blocRegister = context.read<BlocRegister>();
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [ThemeApp.color.light, ThemeApp.color.primary, ThemeApp.color.secondary, ThemeApp.color.dark],
                  center: const Alignment(0, 1),
                  radius: 1.2,
                ),
              ),
              child: Transform.translate(
                offset: Offset(0, keyboardHeight > 0 ? (-keyboardHeight + 50) : 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      Asset.lgLogo,
                      width: 120,
                      height: 120,
                    ),
                    const SizedBox(
                      height: 65,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 47),
                      child: Column(
                        children: [
                          FieldText(
                            placeHolder: "Username",
                            controller: blocRegister.usernameController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FieldText(
                            placeHolder: "Email Address",
                            controller: blocRegister.emailController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FieldPassword(
                            placeHolder: "Password",
                            controller: blocRegister.passwordController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ButtonOutline(
                                  onPress: () => Navigator.of(context).pushNamedAndRemoveUntil(
                                    RouteName.LOGIN,
                                    (route) => false,
                                  ),
                                  child: Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                                    style: ThemeApp.font.semiBold.copyWith(color: ThemeApp.color.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                flex: 2,
                                child: Button(
                                  onPress: () => blocRegister.onRegister(context),
                                  child: Text(
                                    "Signup",
                                    textAlign: TextAlign.center,
                                    style: ThemeApp.font.semiBold.copyWith(color: ThemeApp.color.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 61,
                    ),
                    Text(
                      "Upgrading Creative Skills Platform",
                      style: ThemeApp.font.medium.copyWith(color: ThemeApp.color.white, fontSize: 10),
                    ),
                    Text(
                      "CV Mahakarya Kreatif Nusantara",
                      style: ThemeApp.font.regular.copyWith(color: ThemeApp.color.white, fontSize: 10),
                    ),
                    const SizedBox(
                      height: 88,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
