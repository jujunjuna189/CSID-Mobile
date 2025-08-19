import 'package:csid_mobile/pages/home/page_home.dart';
import 'package:csid_mobile/pages/learning/page_learning.dart';
import 'package:csid_mobile/pages/profile/page_profile.dart';
import 'package:flutter/material.dart';

class PageModel {
  int index;
  String path;
  Widget screen;

  PageModel({required this.index, required this.path, required this.screen});
}

class PageData {
  static final data = [
    PageModel(index: 0, path: "home", screen: const PageHome()),
    PageModel(index: 1, path: "learning", screen: const PageLearning()),
    PageModel(index: 2, path: "profile", screen: const PageProfile()),
  ];
}
