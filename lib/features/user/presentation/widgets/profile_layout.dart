import 'package:cleanarch/core/di/di_container.dart' as di;
import 'package:cleanarch/core/util/user_avatar_builder.dart';
import 'package:cleanarch/core/widgets/navbar/app_bottom_navbar.dart';
import 'package:cleanarch/features/Posts/presentation/Pages/posts_page.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/presentation/widgets/ink_well_container.dart';
import 'package:cleanarch/features/user/presentation/widgets/profile_info.dart';
import 'package:cleanarch/features/user/presentation/widgets/profile_tab_bar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileLayout extends StatelessWidget {
  final bool isView;
  final User user;
  const ProfileLayout({super.key, required this.isView, required this.user});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            clipBehavior: Clip.none,
            expandedHeight: 240,
            leadingWidth: 50,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: isView
                  ? InkWellContainer(
                      iconSize: 20,
                      containerSize: 40,
                      icon: Icons.arrow_back,
                      onTap: () => context.pop(),
                    )
                  : Builder(
                      builder: (context) {
                        return InkWellContainer(
                          icon: Icons.menu,
                          containerSize: 40,
                          iconSize: 20,
                          onTap: () {
                            AppBottomNavBar.openDrawer();
                          },
                        );
                      },
                    ),
            ),
            collapsedHeight: 80,
            backgroundColor: Theme.of(context).cardColor,
            flexibleSpace: userAvatarBuilder(user),
          ),
          // 2. Profile Info with top padding for avatar
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).cardColor,
              padding: EdgeInsets.only(top: 10),
              child: ProfileInfo(user: user, isView: isView),
            ),
          ),
          // 3. Pinned Tabs
          SliverPersistentHeader(
            pinned: true,
            delegate: ProfileTabBarDelegate(),
          ),
        ];
      },
      body: TabBarView(
        children: [
          _buildPostsList(context, "Posts"),
          _buildPostsList(context, "Liked Posts"),
        ],
      ),
    );
  }

  Widget _buildPostsList(BuildContext context, String title) {
    switch (title) {
      case "Posts":
        return BlocProvider(
          create: (context) =>
              di.dc<PostsBloc>()..add(GetPostbyUserIdEvent(user.id)),
          child: PostsPage(isPage: false),
        );
      case "Liked Posts":
        return BlocProvider(
          create: (_) =>
              di.dc<PostsBloc>()..add(GetLikedPostsEvent(uid: user.id)),
          child: PostsPage(isPage: false),
        );
      default:
        return BlocProvider(
          create: (context) =>
              di.dc<PostsBloc>()..add(GetPostbyUserIdEvent(user.id)),
          child: PostsPage(isPage: false),
        );
    }
  }
}
