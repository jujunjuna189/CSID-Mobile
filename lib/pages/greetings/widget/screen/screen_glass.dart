import 'package:csid_mobile/utils/asset/asset.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class ScreenGlass extends StatelessWidget {
  const ScreenGlass({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Asset.ilGlass,
            width: 260,
            height: 246,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "WELCOME TO",
            style: ThemeApp.font.semiBold.copyWith(color: ThemeApp.color.white, fontSize: 30),
          ),
          Text(
            "CREATIVITY AREA",
            style: ThemeApp.font.semiBold.copyWith(color: ThemeApp.color.white, fontSize: 30),
          ),
          const SizedBox(
            height: 70,
          ),
          const SizedBox(
            height: 4,
          ),
          const SizedBox(
            height: 65,
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
    );
  }
}
