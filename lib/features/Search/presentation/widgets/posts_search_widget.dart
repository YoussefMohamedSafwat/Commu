import 'package:cleanarch/features/Search/presentation/bloc/search_bloc.dart';
import 'package:cleanarch/features/Search/presentation/cubit/filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PostsSearchWidget extends StatelessWidget {
  const PostsSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        if (value.trim().isNotEmpty) {
          final filter = context.read<FilterCubit>().state;
          context.read<SearchBloc>().add(
            AddRecentSearchEvent(query: value.trim()),
          );
          context.pushNamed(
            "search-results",
            extra: {'query': value.trim(), 'filter': filter},
          );
        }
      },
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
