import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/posts_page/tags_list.dart';
import 'package:cleanarch/features/Reacts/presentation/widgets/React_list.dart';
import 'package:cleanarch/features/user/presentation/blocs/bloc/user_bloc.dart';
import 'package:cleanarch/features/user/presentation/widgets/user_widget.dart';
import 'package:cleanarch/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCard extends StatelessWidget {
  final int postId;
  final String title;
  final String body;
  final List<String> tags;

  const PostCard({
    super.key,
    required this.postId,
    required this.title,
    required this.body,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            BlocProvider(
              create: (context) =>
                  di.dc<UserBloc>()..add(GetUserByIdEvent(userId: postId)),
              child: UserWidget(postId: postId),
            ),

            // title
            Text(title, style: AppTextStyle.titleText),

            // body
            Text(body),

            SizedBox(height: 5),

            // tags
            TagsList(tags: tags),

            // reactions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ReactList(postId: postId),
            ),
          ],
        ),
      ),
    );
  }
}
