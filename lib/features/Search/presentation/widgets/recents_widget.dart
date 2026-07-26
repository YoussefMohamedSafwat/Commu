import 'package:cleanarch/core/theming/app_theme.dart';
import 'package:cleanarch/features/Search/presentation/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentsWidget extends StatelessWidget {
  final String text;

  const RecentsWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.history),
      title: Text(text, style: context.normalTextHigh),
      trailing: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text("Remove Recent Search", style: context.heading),
                content: Text(
                  "Are you sure you want to remove '$text' from your recent searches?",
                  style: context.normalText,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: context.textSecondaryColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      context.read<SearchBloc>().add(
                        RemoveRecentSearchEvent(query: text),
                      );
                    },
                    child: Text(
                      "Remove",
                      style: context.normalText.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(Icons.close),
      ),
    );
  }
}
