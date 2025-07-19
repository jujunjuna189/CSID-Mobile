import 'package:csid_mobile/pages/home/page_home.dart';
import 'package:csid_mobile/pages/learning/page_learning.dart';
import 'package:csid_mobile/pages/profile/page_profile.dart';
import 'package:flutter/material.dart';

class PageModel {
  int index;
  Widget screen;

  PageModel({required this.index, required this.screen});
}

class PageData {
  static final data = [
    PageModel(index: 0, screen: const PageHome()),
    PageModel(index: 1, screen: const PageLearning()),
    PageModel(index: 2, screen: const PageProfile()),
  ];
}
