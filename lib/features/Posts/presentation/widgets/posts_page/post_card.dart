import 'package:cleanarch/core/cubit/current_user_cubit.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/posts_page/tags_list.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/shared/post_drop_down.dart';
import 'package:cleanarch/features/Reacts/presentation/widgets/react_list.dart';
import 'package:cleanarch/features/user/presentation/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/posts_page/post_image_container.dart';

class PostCard extends StatelessWidget {
  final int postId;
  final String userId;
  final String title;
  final String body;
  final List<String> tags;
  final int reactCount;
  final int commentCount;
  final List<String>? imagesUrl;

  const PostCard({
    super.key,
    required this.postId,
    required this.title,
    required this.body,
    required this.tags,
    required this.userId,
    required this.reactCount,
    required this.commentCount,
    this.imagesUrl,
  });

  Widget _handleCurrentUser(BuildContext context) {
    final currentUser = context.read<CurrentUserCubit>().state;
    final isCurrentUser = currentUser?.id == userId;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            if (isCurrentUser) {
              context.goNamed('userprofile');
            } else {
              context.pushNamed("profileview", pathParameters: {"uid": userId});
            }
          },
          child: UserWidget(
            isUser: isCurrentUser,
            userId: userId,
            builder: (context, user) => Row(
              spacing: 8,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: user.imageUrl != null
                      ? NetworkImage(user.imageUrl!)
                      : null,
                  child: user.imageUrl == null
                      ? const Icon(Icons.person, size: 15)
                      : null,
                ),
                Text(user.username, style: context.normalText),
              ],
            ),
          ),
        ),
        if (isCurrentUser) PostDropDown(postId: postId),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            _handleCurrentUser(context),

            // title
            Text(title, style: context.titleText),

            // body
            ReadMoreText(
              body,
              trimLines: 3,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'See more',
              trimExpandedText: 'See less',
              style: context.body,
              moreStyle: context.subTitleText,
              lessStyle: context.subTitleText,
            ),

            if (imagesUrl != null && imagesUrl!.isNotEmpty)
              PostImageContainer(imagesUrl: imagesUrl!),

            // tags
            TagsList(tags: tags),

            // reactions
            ReactList(
              postId: postId,
              reactCount: reactCount,
              commentCount: commentCount,
            ),
          ],
        ),
      ),
    );
  }
}
