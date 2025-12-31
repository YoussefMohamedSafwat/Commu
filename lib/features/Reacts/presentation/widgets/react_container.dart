import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class ReactContainer extends StatelessWidget {
  final bool islike;
  const ReactContainer({super.key, required this.islike});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(islike ? Icons.thumb_up : Icons.thumb_down, size: 25),
          color: Colors.blueGrey[300],

          onPressed: () {},
        ),
        SizedBox(width: 4),
        Text(
          '0',
          style: AppTextStyle.subTitleText.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
