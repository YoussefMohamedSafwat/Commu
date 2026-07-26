import 'package:cleanarch/core/theming/app_theme.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/features/user/presentation/widgets/profile_container.dart';
import 'package:cleanarch/features/followers/presentation/cubit/follow_cubit.dart';
import 'package:cleanarch/features/followers/presentation/cubit/follow_state.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/presentation/pages/profile_view_page.dart';
import 'package:cleanarch/features/user/presentation/blocs/bloc/user_bloc.dart';
import 'package:cleanarch/core/di/di_container.dart' as di;
import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class FollowSheet extends StatelessWidget {
  final String label;
  final List<User> users;
  const FollowSheet({super.key, required this.label, this.users = const []});

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: bottom, top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: context.titleText),
            SizedBox(height: 16),
            if (users.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text('No $label yet.', style: context.body),
              )
            else
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return _FollowListItem(user: user, index: index);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _FollowListItem extends StatefulWidget {
  final User user;
  final int index;
  const _FollowListItem({required this.user, required this.index});

  @override
  State<_FollowListItem> createState() => _FollowListItemState();
}

class _FollowListItemState extends State<_FollowListItem>
    with AutomaticKeepAliveClientMixin {
  late final FollowCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = di.dc<FollowCubit>()..initLight(widget.user.id);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // We don't want to show a follow button for the current logged in user
    final currentUserId = di.dc<SupabaseClient>().auth.currentUser?.id;
    final isMe = currentUserId == widget.user.id;

    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<FollowCubit, FollowState>(
        builder: (context, state) {
          bool isFollowing = false;
          bool isLoading = state is FollowLoading;
          if (state is FollowLoaded) {
            isFollowing = state.isFollowing;
            isLoading = state.isLoading;
          }

          return ListTile(
            leading: ProfileContainer(
              width: 40,
              height: 40,
              borderWidth: 0,
              imageUrl: widget.user.imageUrl ?? '',
              heroTag: 'follower_${widget.user.id}_${widget.index}',
            ),
            title: Text(
              widget.user.name ?? widget.user.username,
              style: context.body,
            ),
            subtitle: Text('@${widget.user.username}', style: context.caption),
            trailing: isMe
                ? null
                : state is FollowLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: ElevatedButton(
                      key: ValueKey(isFollowing),
                      onPressed: isLoading
                          ? null
                          : () {
                              context.read<FollowCubit>().toggleFollow(
                                widget.user.id,
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFollowing
                            ? AppColors.darkTextTertiary
                            : context.primaryColor,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: isLoading
                            ? const SizedBox(
                                key: ValueKey('loading'),
                                height: 14,
                                width: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                isFollowing ? "Following" : "Follow",
                                key: const ValueKey('text'),
                                style: context.buttonTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                      ),
                    ),
                  ),
            onTap: () {
              context.pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) =>
                        di.dc<UserBloc>()
                          ..add(GetUserByIdEvent(userId: widget.user.id)),
                    child: const ProfileViewPage(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
