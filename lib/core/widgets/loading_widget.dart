import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 20),
        child: CircularProgressIndicator(color: Colors.blue),
      ),
    );
  }
}
