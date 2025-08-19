import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.child, this.colors, this.isBorder = true, this.onPress});

  final Widget child;
  final List<Color>? colors;
  final bool isBorder;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(isBorder ? 2 : 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ThemeApp.color.white.withOpacity(0.4), ThemeApp.color.light],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: ThemeApp.color.light.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(100),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors ??
                  [const Color.fromRGBO(87, 44, 220, 1), const Color.fromRGBO(183, 113, 244, 1), ThemeApp.color.light],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: child,
        ),
      ),
    );
  }
}
