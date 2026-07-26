import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileTabBarDelegate extends SliverPersistentHeaderDelegate {
  ProfileTabBarDelegate();

  @override
  double get minExtent => kTextTabBarHeight; // 48.0 — actual TabBar height

  @override
  double get maxExtent => kTextTabBarHeight; // 48.0

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).cardColor,
      child: TabBar(
        // ✅ built here, gets live context
        labelStyle: context.body.copyWith(fontWeight: FontWeight.bold),
        tabs: const [
          Tab(text: 'Posts'),
          Tab(text: 'Liked'),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(ProfileTabBarDelegate oldDelegate) {
    return true;
  }
}
