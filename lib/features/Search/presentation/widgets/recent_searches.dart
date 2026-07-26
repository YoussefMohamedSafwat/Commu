import 'package:cleanarch/core/theming/app_theme.dart';
import 'package:cleanarch/features/Search/presentation/bloc/search_bloc.dart';
import 'package:cleanarch/features/Search/presentation/cubit/filter_cubit.dart';
import 'package:cleanarch/features/Search/presentation/widgets/recents_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RecentSearchesLoaded) {
          final searches = state.searches;
          if (searches.isEmpty) {
            return const SizedBox();
          }
          return Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Recent Searches", style: context.heading),
              ListView.separated(
                separatorBuilder: (_, _) => const Divider(thickness: 0.7),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: searches.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      final filter = context.read<FilterCubit>().state;
                      context.pushNamed(
                        "search-results",
                        extra: {'query': searches[index], 'filter': filter},
                      );
                    },
                    child: RecentsWidget(text: searches[index]),
                  );
                },
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
