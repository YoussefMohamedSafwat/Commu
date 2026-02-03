import 'package:cleanarch/core/di/di_container.dart' as di;
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/posts_page/tags_list.dart';
import 'package:cleanarch/features/Reacts/presentation/widgets/react_list.dart';
import 'package:cleanarch/features/user/presentation/blocs/bloc/user_bloc.dart';
import 'package:cleanarch/features/user/presentation/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PostCard extends StatelessWidget {
  final int postId;
  final int userId;
  final String title;
  final String body;
  final List<String> tags;
  const PostCard({
    super.key,
    required this.postId,
    required this.title,
    required this.body,
    required this.tags,
    required this.userId,
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
                  di.dc<UserBloc>()..add(GetUserByIdEvent(userId: userId)),
              child: InkWell(
                child: UserWidget(isUser: false),
                onTap: () {
                  context.goNamed(
                    "profileview",
                    pathParameters: {"uid": "$userId"},
                  );
                },
              ),
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
