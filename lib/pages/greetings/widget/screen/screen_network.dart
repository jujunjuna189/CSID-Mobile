import 'package:csid_mobile/routes/route_name.dart';
import 'package:csid_mobile/utils/asset/asset.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:csid_mobile/widgets/atoms/button/button.dart';
import 'package:csid_mobile/widgets/molecules/animation/animation_shimmer.dart';
import 'package:flutter/material.dart';

class ScreenNetwork extends StatelessWidget {
  const ScreenNetwork({super.key});

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
            Asset.ilNetwork,
            width: 260,
            height: 246,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "READY FOR",
            style: ThemeApp.font.semiBold.copyWith(color: ThemeApp.color.white, fontSize: 30),
          ),
          Text(
            "THE NEXT LEVEL",
            style: ThemeApp.font.semiBold.copyWith(color: ThemeApp.color.white, fontSize: 30),
          ),
          const SizedBox(
            height: 47,
          ),
          SizedBox(
            width: 170,
            child: AnimationShimmer(
              child: Button(
                onPress: () => Navigator.of(context).pushNamed(RouteName.LOGIN),
                child: Text(
                  "Get Started",
                  textAlign: TextAlign.center,
                  style: ThemeApp.font.semiBold.copyWith(color: ThemeApp.color.white, fontSize: 12),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 48,
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
