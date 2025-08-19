import 'package:csid_mobile/utils/asset/asset.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 5,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ThemeApp.color.primary.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            Asset.icNotFound,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "Kamu belum punya kelas",
          style: ThemeApp.font.bold.copyWith(fontSize: 16, color: ThemeApp.color.white.withOpacity(0.8)),
        ),
        Text(
          "Yuk, pilih kelas dan mulai belajar!",
          style: ThemeApp.font.regular.copyWith(fontSize: 12, color: ThemeApp.color.white.withOpacity(0.8)),
        ),
      ],
    );
  }
}
