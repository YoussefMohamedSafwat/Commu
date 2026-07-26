import 'package:cleanarch/core/di/di_container.dart' as di;
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/util/keyboard_dismiss_ontap.dart';
import 'package:cleanarch/features/Posts/presentation/Pages/posts_page.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:cleanarch/features/Search/presentation/widgets/filter_widget.dart';
import 'package:cleanarch/features/Search/presentation/widgets/posts_search_widget.dart';
import 'package:cleanarch/features/Search/presentation/widgets/recent_searches.dart';
import 'package:cleanarch/features/Search/presentation/widgets/suggested_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cleanarch/features/Search/presentation/bloc/search_bloc.dart';

class PostsSearchPage extends StatelessWidget {
  const PostsSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.dc<PostsBloc>()..add(GetTrendingPostsEvent()),
        ),
        BlocProvider(
          create: (_) => di.dc<SearchBloc>()..add(LoadRecentSearchesEvent()),
        ),
      ],
      child: KeyboardDismissOnTap(
        child: Scaffold(
          appBar: _buildappbar(context),
          body: _buildbody(context),
        ),
      ),
    );
  }

  AppBar _buildappbar(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: SearchFilterDropdown(),
        ),
      ],
      title: PostsSearchWidget(),
      centerTitle: true,
    );
  }

  Widget _buildbody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SuggestedUsers(),
            RecentSearches(),
            Divider(thickness: 0.7),
            Text("Trending", style: context.heading),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: PostsPage(isPage: false, shrinkWrap: true),
            ),
          ],
        ),
      ),
    );
  }
}
