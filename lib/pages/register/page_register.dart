import 'package:csid_mobile/routes/route_name.dart';
import 'package:csid_mobile/utils/asset/asset.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:csid_mobile/widgets/atoms/button/button.dart';
import 'package:csid_mobile/widgets/atoms/button/button_outline.dart';
import 'package:csid_mobile/widgets/atoms/field/field_text.dart';
import 'package:flutter/material.dart';

class PageRegister extends StatelessWidget {
  const PageRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        const FieldText(
                          placeHolder: "Username",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const FieldText(
                          placeHolder: "Email Address",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const FieldText(
                          placeHolder: "Password",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ButtonOutline(
                                onPress: () => Navigator.of(context).pushNamed(RouteName.LOGIN),
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
        ],
      ),
    );
  }
}
