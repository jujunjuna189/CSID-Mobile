import 'package:csid_mobile/utils/asset/asset.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:csid_mobile/widgets/atoms/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigatorBottom extends StatelessWidget {
  const NavigatorBottom({super.key, required this.onJump});
  final Function onJump;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 10,
      right: 10,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ThemeApp.color.dark,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => onJump(0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: ThemeApp.color.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: SvgPicture.asset(
                  Asset.icHome,
                  width: 19,
                  height: 19,
                  color: ThemeApp.color.white,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Button(
                onPress: () => onJump(1),
                child: Text(
                  "Start Learning",
                  textAlign: TextAlign.center,
                  style: ThemeApp.font.medium.copyWith(color: ThemeApp.color.white),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () => onJump(2),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: ThemeApp.color.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: SvgPicture.asset(
                  Asset.icUser,
                  width: 19,
                  height: 19,
                  color: ThemeApp.color.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
