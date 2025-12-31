import 'package:cleanarch/core/util/keyboard_dismiss_ontap.dart';
import 'package:cleanarch/features/Search/presentation/widgets/posts_search_widget.dart';
import 'package:flutter/material.dart';

class PostsSearchPage extends StatelessWidget {
  const PostsSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(appBar: _buildappbar(context), body: _buildbody(context)),
    );
  }

  AppBar _buildappbar(BuildContext context) {
    return AppBar(title: PostsSearchWidget(), centerTitle: true);
  }

  Widget _buildbody(BuildContext context) {
    return Column(children: []);
  }
}
