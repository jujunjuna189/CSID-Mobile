import 'package:csid_mobile/utils/asset/asset.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
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
          "Tidak ada kelas",
          style: ThemeApp.font.bold.copyWith(fontSize: 16, color: ThemeApp.color.white.withOpacity(0.8)),
        ),
        Text(
          "CSID Academic, belum menyediakan",
          style: ThemeApp.font.regular.copyWith(fontSize: 12, color: ThemeApp.color.white.withOpacity(0.8)),
        ),
        Text(
          "kelas untuk kamu pelajari :(",
          style: ThemeApp.font.regular.copyWith(fontSize: 12, color: ThemeApp.color.white.withOpacity(0.8)),
        ),
      ],
    );
  }
}

class NotFoundF2 extends StatelessWidget {
  const NotFoundF2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
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
