import 'package:cleanarch/core/constants/app_sizes.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/post_detail_page/delete_post_btn.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/post_detail_page/edit_post_btn.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostDetailPage extends StatelessWidget {
  final Posts post;
  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildappbar(context), body: _buildbody(context));
  }

  AppBar _buildappbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: Icon(Icons.home),
      ),
      title: Text("Post Detail"),
    );
  }

  Widget _buildbody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: _columnWidget(post),
    );
  }

  Widget _columnWidget(Posts post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,

      children: [
        Text(
          post.title,
          style: AppTextStyle.titleText.copyWith(fontSize: AppSizes.s20),
        ),
        Card(
          elevation: 1,
          child: Text(
            post.body,
            style: AppTextStyle.subTitleText.copyWith(fontSize: AppSizes.s24),
          ),
        ),
        Row(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            EditPostBtn(post: post),
            DeletePostBtn(postId: post.id),
          ],
        ),
      ],
    );
  }
}
