import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class ButtonOutline extends StatelessWidget {
  const ButtonOutline({super.key, required this.child, this.color, this.onPress});

  final Widget child;
  final Color? color;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: ThemeApp.color.light.withOpacity(0.1),
          border: Border.all(width: 1, color: ThemeApp.color.light.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(100),
        ),
        child: child,
      ),
    );
  }
}
