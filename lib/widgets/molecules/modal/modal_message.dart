import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:csid_mobile/widgets/atoms/button/button.dart';
import 'package:csid_mobile/widgets/atoms/button/button_outline.dart';
import 'package:flutter/material.dart';

class ModalMessage {
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = "OK",
    VoidCallback? onConfirm,
    String? secondaryText, // nullable button text
    VoidCallback? onSecondary, // nullable button action
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: true, // bisa ditutup dengan tap di luar
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 25),

                // Row kalau ada 2 button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (secondaryText != null)
                      Expanded(
                        child: ButtonOutline(
                          onPress: () {
                            Navigator.of(context).pop();
                            if (onSecondary != null) onSecondary();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              secondaryText,
                              textAlign: TextAlign.center,
                              style: ThemeApp.font.semiBold.copyWith(
                                color: ThemeApp.color.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (secondaryText != null) const SizedBox(width: 12),
                    Expanded(
                      child: Button(
                        onPress: () {
                          Navigator.of(context).pop();
                          if (onConfirm != null) onConfirm();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            confirmText,
                            textAlign: TextAlign.center,
                            style: ThemeApp.font.semiBold.copyWith(
                              color: ThemeApp.color.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
