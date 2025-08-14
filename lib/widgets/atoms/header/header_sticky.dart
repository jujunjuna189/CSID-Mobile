import 'package:flutter/material.dart';

class HeaderSticky extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;
  HeaderSticky({required this.height, required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant HeaderSticky oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}
