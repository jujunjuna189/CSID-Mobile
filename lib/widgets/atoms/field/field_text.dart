import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class FieldText extends StatelessWidget {
  final TextEditingController? controller;
  final Function? onChange;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  final String? placeHolder;
  final bool border;
  final Map? style;
  const FieldText(
      {Key? key,
      this.controller,
      this.onChange,
      this.padding,
      this.height = 45,
      this.width,
      this.placeHolder,
      this.border = true,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: ThemeApp.color.light.withOpacity(0.1),
        border: border ? Border.all(width: 1, color: ThemeApp.color.light.withOpacity(0.5)) : null,
        borderRadius: BorderRadius.circular(100),
      ),
      height: height,
      width: width,
      constraints: const BoxConstraints(minHeight: 10),
      child: TextField(
        controller: controller,
        cursorColor: ThemeApp.color.primary,
        onChanged: ((value) => onChange != null ? onChange!(value) : {}),
        keyboardType: TextInputType.text,
        style: ThemeApp.font.medium.copyWith(fontSize: 14, color: ThemeApp.color.white),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: placeHolder ?? '',
          hintStyle: ThemeApp.font.regular.copyWith(fontSize: 14, color: ThemeApp.color.white),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }
}
