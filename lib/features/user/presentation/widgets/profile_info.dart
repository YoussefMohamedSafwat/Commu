import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/util/bottom_sheet.dart';
import 'package:cleanarch/features/followers/presentation/widgets/follow_sheet.dart';
import 'package:cleanarch/features/followers/presentation/cubit/follow_cubit.dart';
import 'package:cleanarch/features/followers/presentation/cubit/follow_state.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfo extends StatelessWidget {
  final User user;
  final bool isView;
  const ProfileInfo({super.key, required this.user, this.isView = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(user.name ?? "", style: context.heading)],
          ),
          Text(
            '@${user.username}',
            style: context.caption.copyWith(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Text(
            user.bio ?? "",
            style: context.body.copyWith(fontSize: 15),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),

          // Followers/Following
          BlocBuilder<FollowCubit, FollowState>(
            builder: (context, state) {
              int followersCount = user.followersCount;
              int followingCount = user.followingCount;

              if (state is FollowLoaded) {
                followersCount = state.followers.length;
                followingCount = state.following.length;
              }

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: state is FollowLoading
                    ? const SizedBox(
                        height: 48,
                        child: Center(
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      )
                    : Row(
                        key: const ValueKey('loaded_stats'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildStatItem(
                            context,
                            "$followersCount",
                            "FOLLOWERS",
                            () {
                              openbBottomSheet(
                                context,
                                FollowSheet(
                                  label: "Followers",
                                  users: state is FollowLoaded
                                      ? state.followers
                                      : [],
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 24),
                          _buildStatItem(
                            context,
                            "$followingCount",
                            "FOLLOWING",
                            () => openbBottomSheet(
                              context,
                              FollowSheet(
                                label: "Following",
                                users: state is FollowLoaded
                                    ? state.following
                                    : [],
                              ),
                            ),
                          ),
                        ],
                      ),
              );
            },
          ),

          if (isView) ...[
            SizedBox(height: 16),
            BlocBuilder<FollowCubit, FollowState>(
              builder: (context, state) {
                bool isFollowing = false;
                bool isLoading = state is FollowLoading;
                if (state is FollowLoaded) {
                  isFollowing = state.isFollowing;
                  isLoading = state.isLoading;
                }
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    key: ValueKey(isFollowing),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              context.read<FollowCubit>().toggleFollow(user.id);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFollowing
                            ? AppColors.darkTextTertiary
                            : AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: isLoading
                            ? const SizedBox(
                                key: ValueKey('loading'),
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                isFollowing ? "Following" : "Follow",
                                key: ValueKey('text'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],

          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      // 👇 The fix: A transparent container with padding
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: AppColors.secondary),
            children: [
              TextSpan(
                text: '$value ',
                style: context.heading.copyWith(fontSize: 16),
              ),
              TextSpan(
                text: label,
                style: context.caption.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
