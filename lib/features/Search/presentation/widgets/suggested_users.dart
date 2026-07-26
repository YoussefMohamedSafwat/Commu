import 'package:cleanarch/core/constants/enums/filter.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarch/core/constants/oreintation.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/widgets/user_layout_avatar.dart';
import 'package:cleanarch/features/user/presentation/blocs/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleanarch/core/di/di_container.dart' as di;
import 'package:supabase_flutter/supabase_flutter.dart';

class SuggestedUsers extends StatelessWidget {
  const SuggestedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final currentUserId = Supabase.instance.client.auth.currentUser!.id;
        return di.dc<UserBloc>()
          ..add(GetSuggestedUsersEvent(currentUserId: currentUserId));
      },
      child: Column(
        spacing: 40,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text("Suggested Users", style: context.heading),
          ),

          SizedBox(
            height: 100,
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SuggestedUsersLoadedState) {
                  final users = state.users;
                  if (users.isEmpty) {
                    return Center(
                      child: Text(
                        "No suggestions right now.",
                        style: context.normalTextHigh,
                      ),
                    );
                  }
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: users.length,
                    shrinkWrap: true,
                    separatorBuilder: (_, _) => const SizedBox(width: 45),
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            "search-results",
                            extra: {
                              'query': user.username,
                              'filter': SearchFilter.users,
                            },
                          );
                        },
                        child: UserLayoutAvatar(
                          user: user,
                          oreintation: Oreintation.vertical,
                        ),
                      );
                    },
                  );
                } else if (state is UserErrorState) {
                  return Center(
                    child: Text(state.message, style: context.titleText),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
