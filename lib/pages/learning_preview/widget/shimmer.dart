import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class Shimmer extends StatelessWidget {
  const Shimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverList.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              color: ThemeApp.color.white.withOpacity(0.1),
              border: Border.all(width: 1, color: ThemeApp.color.white.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(25),
            ),
          );
        },
      ),
    );
  }
}

class ShimmerF2 extends StatelessWidget {
  const ShimmerF2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 0),
            width: 250,
            height: 310,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ThemeApp.color.grey.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            width: 250,
            height: 310,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ThemeApp.color.grey.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            width: 250,
            height: 310,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ThemeApp.color.grey.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}
