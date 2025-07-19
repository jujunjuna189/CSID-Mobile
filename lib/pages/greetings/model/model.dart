import 'package:csid_mobile/pages/greetings/widget/screen/screen_glass.dart';
import 'package:csid_mobile/pages/greetings/widget/screen/screen_network.dart';
import 'package:csid_mobile/pages/greetings/widget/screen/screen_rocket.dart';
import 'package:flutter/material.dart';

class ScreenModel {
  int index;
  Widget screen;

  ScreenModel({required this.index, required this.screen});
}

class ScreenData {
  static final data = [
    ScreenModel(index: 0, screen: const ScreenGlass()),
    ScreenModel(index: 1, screen: const ScreenRocket()),
    ScreenModel(index: 2, screen: const ScreenNetwork()),
  ];
}
