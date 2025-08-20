import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csid_mobile/pages/main/bloc/bloc_main.dart';
import 'package:csid_mobile/pages/main/model/model.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:csid_mobile/widgets/molecules/navigator/navigator_bottom.dart';
import 'package:flutter/material.dart';

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  late BlocMain blocMain;
  int _currentIndex = 0;
  DateTime? _lastPressed;

  @override
  void initState() {
    super.initState();
    blocMain = context.read<BlocMain>();
    blocMain.pageController ??= PageController(initialPage: 0);
  }

  Future<bool> _onPopWithResult(dynamic result) async {
    final now = DateTime.now();

    if (_currentIndex != 0) {
      // Jika bukan home, kembali ke home dulu
      blocMain.pageController?.jumpToPage(0);
      return false; // cegah pop
    }

    // Jika di home, cek double-tap
    if (_lastPressed == null || now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tekan sekali lagi untuk keluar"),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    } else {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        _onPopWithResult(result);
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        ThemeApp.color.light,
                        ThemeApp.color.primary,
                        ThemeApp.color.secondary,
                        ThemeApp.color.dark
                      ],
                      center: const Alignment(0, 1),
                      radius: 1.2,
                    ),
                  ),
                  child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      controller: blocMain.pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (_, i) {
                        return PageData.data[i].screen;
                      }),
                ),
              ),
              NavigatorBottom(
                path: PageData.data[_currentIndex].path,
                onJump: (value) {
                  blocMain.pageController?.jumpToPage(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
