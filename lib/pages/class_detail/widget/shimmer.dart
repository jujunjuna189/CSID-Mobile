import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class Shimmer extends StatelessWidget {
  const Shimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            color: ThemeApp.color.white.withOpacity(0.1),
            border: Border.all(width: 1, color: ThemeApp.color.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            color: ThemeApp.color.white.withOpacity(0.1),
            border: Border.all(width: 1, color: ThemeApp.color.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            color: ThemeApp.color.white.withOpacity(0.1),
            border: Border.all(width: 1, color: ThemeApp.color.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(25),
          ),
        )
      ],
    );
  }
}
